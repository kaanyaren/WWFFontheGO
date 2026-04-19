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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            itemCount: spots.length,
            itemBuilder: (context, index) {
              final spot = spots[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    // Navigate to LogEntryPage with pre-filled data
                    context.push('/log/new', extra: spot);
                  },
                  child: GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              spot.callsign,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                spot.wwff,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.settings_input_antenna, size: 16, color: Colors.blueGrey),
                            const SizedBox(width: 4),
                            Text(spot.freq, style: const TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 16),
                            const Icon(Icons.keyboard_outlined, size: 16, color: Colors.blueGrey),
                            const SizedBox(width: 4),
                            Text(spot.mode, style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        if (spot.comments != null && spot.comments!.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            spot.comments!,
                            style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.black54),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              'by ${spot.spotter}',
                              style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat('HH:mm').format(spot.spotTime) + ' UTC',
                              style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ],
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
}
