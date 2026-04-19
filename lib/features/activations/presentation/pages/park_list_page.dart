import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/theme/glass_card.dart';
import '../../data/repositories/park_repository.dart';
import '../../domain/models/park.dart';

class ParkListPage extends HookConsumerWidget {
  const ParkListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final parkListAsync = ref.watch(parkListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WWFF Parks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Syncing parks from Firebase...')),
              );
              await ref.read(parkRepositoryProvider).syncParksFromFirestore();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search by reference or name...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                ),
                onChanged: (val) => searchQuery.value = val,
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
                  return const Center(child: Text('No parks found. Try syncing!'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: filteredParks.length,
                  itemBuilder: (context, index) {
                    final park = filteredParks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
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
                                  errorBuilder: (_, __, ___) => _buildPlaceholder(),
                                ),
                              )
                            else
                              _buildPlaceholder(),
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
                                    style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.forest, color: Colors.green),
    );
  }
}
