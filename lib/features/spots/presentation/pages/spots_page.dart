import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/glass_card.dart';
import '../../data/services/spots_service.dart';
import '../../domain/models/spot.dart';

class SpotsPage extends ConsumerWidget {
  const SpotsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotsAsync = ref.watch(spotsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live WWFF Spots'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(spotsProvider),
          ),
        ],
      ),
      body: spotsAsync.when(
        data: (spots) {
          if (spots.isEmpty) {
            return const Center(child: Text('No active spots at the moment.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: spots.length,
            itemBuilder: (context, index) {
              final spot = spots[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => context.push('/log/new', extra: spot),
                  borderRadius: BorderRadius.circular(20),
                  child: GlassCard(
                    padding: const EdgeInsets.all(0),
                    borderRadius: 20,
                    opacity: 0.15, // Sleeker look
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: _getModeColor(spot.mode),
                            width: 6,
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
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  Text(
                                    'by ${spot.spotter}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.blueGrey.withOpacity(0.8),
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
                                Icons.settings_input_antenna,
                                spot.freq,
                                Colors.blue,
                              ),
                              const SizedBox(width: 8),
                              _buildInfoChip(
                                context,
                                Icons.keyboard_outlined,
                                spot.mode,
                                _getModeColor(spot.mode),
                              ),
                              const Spacer(),
                              Text(
                                DateFormat('HH:mm').format(spot.spotTime),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const Text(
                                ' UTC',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blueGrey,
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
                                color: Colors.black.withOpacity(0.03),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                spot.comments!,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black.withOpacity(0.7),
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
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
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
              color: color.withOpacity(0.8),
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

