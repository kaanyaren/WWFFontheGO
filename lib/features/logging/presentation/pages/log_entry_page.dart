import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/glass_card.dart';
import '../../data/repositories/qso_repository.dart';
import '../../domain/models/qso_log.dart';
import '../../../settings/data/repositories/settings_repository.dart';

class LogEntryPage extends HookConsumerWidget {
  const LogEntryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    
    final callsignController = useTextEditingController();
    final rstSentController = useTextEditingController(text: '59');
    final rstRcvdController = useTextEditingController(text: '59');
    final sigInfoController = useTextEditingController();
    final commentController = useTextEditingController();
    
    final selectedBand = useState('20m');
    final selectedMode = useState('SSB');

    return Scaffold(
      appBar: AppBar(
        title: const Text('New QSO'),
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) return const Center(child: Text('Please set up your profile first.'));

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              GlassCard(
                child: Column(
                  children: [
                    TextFormField(
                      controller: callsignController,
                      decoration: const InputDecoration(
                        labelText: 'Hunter Callsign',
                        prefixIcon: Icon(Icons.search),
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
                            decoration: const InputDecoration(labelText: 'RST Sent'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: rstRcvdController,
                            decoration: const InputDecoration(labelText: 'RST Rcvd'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: sigInfoController,
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
              ElevatedButton(
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
                child: const Text('Save QSO'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
