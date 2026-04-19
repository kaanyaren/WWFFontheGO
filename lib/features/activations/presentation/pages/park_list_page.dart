import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/glass_card.dart';
import '../../../../core/widgets/animated_list_item.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../data/repositories/park_repository.dart';
import '../widgets/park_map_view.dart';

class ParkListPage extends HookConsumerWidget {
  const ParkListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final isMapView = useState(true); // Default to map as requested
    final parkListAsync = ref.watch(parkListProvider);
    final brightness = Theme.of(context).brightness;

    useEffect(() {
      parkListAsync.whenData((parks) {
        if (parks.isEmpty) {
          ref.read(parkRepositoryProvider).syncParksFromCSV();
        }
      });
      return null;
    }, [parkListAsync.hasValue]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WWFFontheGO'),
        actions: [
          IconButton(
            icon: Icon(isMapView.value ? Icons.list_rounded : Icons.map_rounded),
            onPressed: () => isMapView.value = !isMapView.value,
            tooltip: isMapView.value ? 'Show List' : 'Show Map',
          ),
          IconButton(
            icon: const Icon(Icons.sync_rounded),
            onPressed: () async {
              try {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Syncing from WWFF Directory...')),
                );
                // Sync from Firestore to Local
                await ref.read(parkRepositoryProvider).syncParksFromCSV();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sync completed!')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sync Error: $e')),
                  );
                }
              }
            },
            tooltip: 'Sync with Cloud Database',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              borderRadius: 16,
              child: SizedBox(
                height: 44,
                child: TextField(
                  controller: searchController,
                  style: TextStyle(
                    fontSize: 14,
                    color: brightness == Brightness.dark
                        ? AppColors.darkOnSurface
                        : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search by reference or name...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.subtext(brightness).withOpacity(0.6),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.subtext(brightness),
                      size: 20,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: (val) => searchQuery.value = val,
                ),
              ),
            ),
          ),
          Expanded(
            child: parkListAsync.when(
              data: (parks) {
                final filteredParks = parks.where((p) {
                  final query = searchQuery.value.toLowerCase();
                  return p.reference.toLowerCase().contains(query) ||
                      p.name.toLowerCase().contains(query) ||
                      p.state.toLowerCase().contains(query);
                }).toList();

                if (filteredParks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.forest_outlined,
                          size: 64,
                          color: AppColors.subtext(brightness).withOpacity(0.4),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No parks found.',
                          style: TextStyle(color: AppColors.subtext(brightness)),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => ref.read(parkRepositoryProvider).syncParksFromCSV(),
                          child: const Text('Refresh from Database'),
                        ),
                      ],
                    ),
                  );
                }

                if (isMapView.value) {
                  return ParkMapView(parks: filteredParks);
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: filteredParks.length,
                  itemBuilder: (context, index) {
                    final park = filteredParks[index];
                    return AnimatedListItem(
                      index: index,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ScaleOnTap(
                          onTap: () => context.push('/park-detail', extra: park),
                          child: GlassCard(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                if (park.imageUrl != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      park.imageUrl!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => _buildPlaceholder(brightness),
                                    ),
                                  )
                                else
                                  _buildPlaceholder(brightness),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        park.reference,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        park.name,
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        park.state,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.subtext(brightness),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: 6,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: ShimmerLoading(width: double.infinity, height: 92),
                ),
              ),
              error: (err, stack) => Center(
                child: Text(
                  'Error: $err',
                  style: TextStyle(color: AppColors.subtext(brightness)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(Brightness brightness) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withOpacity(
          brightness == Brightness.dark ? 0.15 : 0.1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.forest,
        color: AppColors.primaryGreen.withOpacity(0.6),
      ),
    );
  }
}
