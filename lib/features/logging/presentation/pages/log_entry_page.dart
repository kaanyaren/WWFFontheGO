import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/glass_card.dart';
import '../../data/repositories/qso_repository.dart';
import '../../domain/models/qso_log.dart';
import '../../../settings/data/repositories/settings_repository.dart';
import '../../../spots/domain/models/spot.dart';

class LogEntryPage extends HookConsumerWidget {
  final WwffSpot? preFillSpot;

  const LogEntryPage({super.key, this.preFillSpot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final brightness = Theme.of(context).brightness;

    final callsignController = useTextEditingController(text: preFillSpot?.callsign ?? '');
    final rstSentController = useTextEditingController(text: '59');
    final rstRcvdController = useTextEditingController(text: '59');
    final sigInfoController = useTextEditingController(text: preFillSpot?.wwff ?? '');
    final commentController = useTextEditingController(text: preFillSpot?.comments ?? '');

    final selectedBand = useState(preFillSpot != null ? _freqToBand(preFillSpot!.freq) : '20m');
    final selectedMode = useState(preFillSpot?.mode ?? 'SSB');

    return Scaffold(
      appBar: AppBar(
        title: const Text('New QSO'),
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return Center(
              child: Text(
                'Please set up your profile first.',
                style: TextStyle(color: AppColors.subtext(brightness)),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              GlassCard(
                child: Column(
                  children: [
                    TextFormField(
                      controller: callsignController,
                      style: TextStyle(
                        color: brightness == Brightness.dark
                            ? AppColors.darkOnSurface
                            : Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Hunter Callsign',
                        prefixIcon: Icon(Icons.search_rounded),
                        hintText: 'e.g. K1ABC',
                      ),
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedBand.value,
                            decoration: const InputDecoration(labelText: 'Band'),
                            dropdownColor: brightness == Brightness.dark
                                ? AppColors.darkSurface
                                : Colors.white,
                            style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? AppColors.darkOnSurface
                                  : Colors.black87,
                            ),
                            items: ['80m', '40m', '30m', '20m', '17m', '15m', '12m', '10m', '6m', '2m']
                                .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                                .toList(),
                            onChanged: (val) => selectedBand.value = val!,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedMode.value,
                            decoration: const InputDecoration(labelText: 'Mode'),
                            dropdownColor: brightness == Brightness.dark
                                ? AppColors.darkSurface
                                : Colors.white,
                            style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? AppColors.darkOnSurface
                                  : Colors.black87,
                            ),
                            items: ['SSB', 'CW', 'FT8', 'FM', 'AM', 'DATA']
                                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                                .toList(),
                            onChanged: (val) => selectedMode.value = val!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: rstSentController,
                            style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? AppColors.darkOnSurface
                                  : Colors.black87,
                            ),
                            decoration: const InputDecoration(labelText: 'RST Sent'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: rstRcvdController,
                            style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? AppColors.darkOnSurface
                                  : Colors.black87,
                            ),
                            decoration: const InputDecoration(labelText: 'RST Rcvd'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: sigInfoController,
                      style: TextStyle(
                        color: brightness == Brightness.dark
                            ? AppColors.darkOnSurface
                            : Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Hunter Park (Sig Info)',
                        hintText: 'e.g. KFF-1234',
                      ),
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
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
                child: ElevatedButton(
                  onPressed: () async {
                    if (callsignController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a callsign')),
                      );
                      return;
                    }

                    final now = DateTime.now().toUtc();
                    final log = QsoLog()
                      ..callsign = callsignController.text.toUpperCase()
                      ..qsoDate = now
                      ..timeOn = DateFormat('HHmmss').format(now)
                      ..band = selectedBand.value
                      ..mode = selectedMode.value
                      ..rstSent = rstSentController.text
                      ..rstRcvd = rstRcvdController.text
                      ..sigInfo = sigInfoController.text.toUpperCase()
                      ..sig = sigInfoController.text.isNotEmpty ? 'WWFF' : null
                      ..stationCallsign = profile.defaultCallsign ?? ''
                      ..operatorCallsign = profile.defaultOperator ?? ''
                      ..mySig = 'WWFF'
                      ..mySigInfo = profile.defaultMySigInfo ?? ''
                      ..txPower = profile.defaultTxPower
                      ..comment = commentController.text;

                    await ref.read(qsoRepositoryProvider).addLog(log);
                    if (context.mounted) context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Save QSO'),
                ),
              ),
            ],
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  String _freqToBand(String freqStr) {
    final freq = double.tryParse(freqStr) ?? 0;
    if (freq >= 3.5 && freq <= 4.0) return '80m';
    if (freq >= 7.0 && freq <= 7.3) return '40m';
    if (freq >= 10.1 && freq <= 10.15) return '30m';
    if (freq >= 14.0 && freq <= 14.35) return '20m';
    if (freq >= 18.068 && freq <= 18.168) return '17m';
    if (freq >= 21.0 && freq <= 21.45) return '15m';
    if (freq >= 24.89 && freq <= 24.99) return '12m';
    if (freq >= 28.0 && freq <= 29.7) return '10m';
    return '20m';
  }
}
