import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/glass_card.dart';
import '../../data/repositories/qso_repository.dart';
import '../../domain/models/qso_log.dart';

class LogListPage extends ConsumerWidget {
  const LogListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qsoListAsync = ref.watch(qsoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WWFF Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // TODO: Implement ADIF Export
            },
          ),
        ],
      ),
      body: qsoListAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_outlined, size: 64, color: Colors.blueGrey),
                  SizedBox(height: 16),
                  Text('No logs yet. Start an activation!'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _buildInfoColumn(log.callsign, log.band, log.mode),
                      const Spacer(),
                      _buildDateColumn(log.qsoDate, log.timeOn),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () => _confirmDelete(context, ref, log),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60), // Room for bottom bar
        child: FloatingActionButton(
          onPressed: () {
            context.push('/log/new');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String callsign, String band, String mode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          callsign,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(band, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(mode, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateColumn(DateTime date, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(DateFormat('yyyy-MM-dd').format(date), style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text('${time.substring(0, 2)}:${time.substring(2, 4)} UTC', 
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, QsoLog log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Log?'),
        content: Text('Are you sure you want to delete the QSO with ${log.callsign}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ref.read(qsoRepositoryProvider).deleteLog(log.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
