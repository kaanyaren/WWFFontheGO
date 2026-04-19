import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/glass_card.dart';
import '../../../../core/widgets/animated_list_item.dart';
import '../../data/repositories/qso_repository.dart';
import '../../domain/models/qso_log.dart';
import '../../../../core/utils/adif_generator.dart';

class LogListPage extends ConsumerWidget {
  const LogListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qsoListAsync = ref.watch(qsoListProvider);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: const Text('WWFF Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              final logs = qsoListAsync.value ?? [];
              if (logs.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No logs to export')),
                );
                return;
              }
              final adif = AdifGenerator.generate(logs);
              Share.share(adif, subject: 'WWFF_Export_${DateFormat('yyyyMMdd').format(DateTime.now())}.adif');
            },
          ),
        ],
      ),
      body: qsoListAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_outlined,
                    size: 64,
                    color: AppColors.subtext(brightness).withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No logs yet. Start an activation!',
                    style: TextStyle(color: AppColors.subtext(brightness)),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return AnimatedListItem(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ScaleOnTap(
                    child: GlassCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          _buildInfoColumn(context, log.callsign, log.band, log.mode, brightness),
                          const Spacer(),
                          _buildDateColumn(log.qsoDate, log.timeOn, brightness),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () => _confirmDelete(context, ref, log, brightness),
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
        loading: () => Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60), // Room for bottom bar
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                AppColors.primaryGreen,
                AppColors.primaryGreen.withValues(alpha: 0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGreen.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              context.push('/log/new');
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(
    BuildContext context,
    String callsign,
    String band,
    String mode,
    Brightness brightness,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          callsign,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: brightness == Brightness.dark
                ? AppColors.darkOnSurface
                : Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withValues(alpha: 
                  brightness == Brightness.dark ? 0.2 : 0.1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                band,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: brightness == Brightness.dark
                      ? AppColors.secondaryGreen
                      : AppColors.primaryGreen,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 
                  brightness == Brightness.dark ? 0.15 : 0.1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                mode,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: brightness == Brightness.dark
                      ? Colors.blue.shade300
                      : Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateColumn(DateTime date, String time, Brightness brightness) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          DateFormat('yyyy-MM-dd').format(date),
          style: TextStyle(
            fontSize: 12,
            color: AppColors.subtext(brightness),
          ),
        ),
        Text(
          '${time.substring(0, 2)}:${time.substring(2, 4)} UTC',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: brightness == Brightness.dark
                ? AppColors.darkOnSurface
                : Colors.black87,
          ),
        ),
      ],
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    QsoLog log,
    Brightness brightness,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Log?',
          style: TextStyle(
            color: brightness == Brightness.dark
                ? AppColors.darkOnSurface
                : Colors.black87,
          ),
        ),
        content: Text(
          'Are you sure you want to delete the QSO with ${log.callsign}?',
          style: TextStyle(
            color: AppColors.subtext(brightness),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.subtext(brightness)),
            ),
          ),
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
