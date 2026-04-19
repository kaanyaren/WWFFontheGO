import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/glass_card.dart';
import '../../../../core/widgets/animated_list_item.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../data/services/spots_service.dart';

class SpotsPage extends ConsumerWidget {
  const SpotsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotsAsync = ref.watch(spotsProvider);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live WWFF Spots'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.refresh(spotsProvider),
          ),
        ],
      ),
      body: spotsAsync.when(
        data: (spots) {
          if (spots.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.radar_outlined,
                    size: 64,
                    color: AppColors.subtext(brightness).withOpacity(0.4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No active spots at the moment.',
                    style: TextStyle(color: AppColors.subtext(brightness)),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: spots.length,
            itemBuilder: (context, index) {
              final spot = spots[index];
              return AnimatedListItem(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ScaleOnTap(
                    onTap: () => context.push('/log/new', extra: spot),
                    child: GlassCard(
                      padding: const EdgeInsets.all(0),
                      borderRadius: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: _getModeColor(spot.mode),
                              width: 5,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      spot.callsign,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -0.5,
                                        color: brightness == Brightness.dark
                                            ? AppColors.darkOnSurface
                                            : Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'by ${spot.spotter}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.subtext(brightness).withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    spot.wwff,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                _buildInfoChip(
                                  context,
                                  Icons.settings_input_antenna_rounded,
                                  spot.freq,
                                  brightness == Brightness.dark
                                      ? Colors.blue.shade300
                                      : Colors.blue,
                                  brightness,
                                ),
                                const SizedBox(width: 8),
                                _buildInfoChip(
                                  context,
                                  Icons.keyboard_outlined,
                                  spot.mode,
                                  _getModeColor(spot.mode),
                                  brightness,
                                ),
                                const Spacer(),
                                Text(
                                  DateFormat('HH:mm').format(spot.spotTime),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.subtext(brightness),
                                  ),
                                ),
                                Text(
                                  ' UTC',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.subtext(brightness),
                                  ),
                                ),
                              ],
                            ),
                            if (spot.comments != null && spot.comments!.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: brightness == Brightness.dark
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.black.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  spot.comments!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                    color: brightness == Brightness.dark
                                        ? AppColors.darkSubtext
                                        : Colors.black.withOpacity(0.7),
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: 5,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: ShimmerLoading(width: double.infinity, height: 140),
          ),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Error: $err',
            style: TextStyle(color: AppColors.subtext(brightness)),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    Brightness brightness,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(brightness == Brightness.dark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Color _getModeColor(String mode) {
    switch (mode.toUpperCase()) {
      case 'SSB':
        return Colors.orange;
      case 'CW':
        return Colors.green;
      case 'FT8':
      case 'FT4':
        return Colors.purple;
      case 'FM':
        return Colors.blue;
      default:
        return Colors.blueGrey;
    }
  }
}
