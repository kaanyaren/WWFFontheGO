import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/theme/glass_card.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/models/user_profile.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final repository = ref.watch(settingsRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) return const Center(child: Text('No Profile Found'));

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              _buildSectionTitle(context, 'Station Information'),
              const SizedBox(height: 16),
              GlassCard(
                child: Column(
                  children: [
                    _buildTextField(
                      label: 'Default Callsign',
                      initialValue: profile.defaultCallsign ?? '',
                      onChanged: (val) => _updateProfile(ref, profile, defaultCallsign: val),
                      icon: Icons.badge_outlined,
                    ),
                    const Divider(height: 32),
                    _buildTextField(
                      label: 'Default Operator',
                      initialValue: profile.defaultOperator ?? '',
                      onChanged: (val) => _updateProfile(ref, profile, defaultOperator: val),
                      icon: Icons.person_outline,
                    ),
                    const Divider(height: 32),
                    _buildTextField(
                      label: 'Current Park (My Sig Info)',
                      initialValue: profile.defaultMySigInfo ?? '',
                      onChanged: (val) => _updateProfile(ref, profile, defaultMySigInfo: val.toUpperCase()),
                      icon: Icons.location_on_outlined,
                      hint: 'e.g. TAFF-0001',
                    ),
                    const Divider(height: 32),
                    _buildNumberField(
                      label: 'Default TX Power (W)',
                      initialValue: profile.defaultTxPower ?? 10,
                      onChanged: (val) => _updateProfile(ref, profile, defaultTxPower: val),
                      icon: Icons.bolt_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildSectionTitle(context, 'App Preferences'),
              const SizedBox(height: 16),
              GlassCard(
                child: SwitchListTile(
                  title: const Text('Dark Theme'),
                  secondary: const Icon(Icons.dark_mode_outlined),
                  value: profile.isDarkTheme,
                  onChanged: (val) => _updateProfile(ref, profile, isDarkTheme: val),
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 80), // Space for bottom bar
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
    required IconData icon,
    String? hint,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        filled: false,
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildNumberField({
    required String label,
    required int initialValue,
    required ValueChanged<int> onChanged,
    required IconData icon,
  }) {
    return TextFormField(
      initialValue: initialValue.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        filled: false,
      ),
      onChanged: (val) {
        final parsed = int.tryParse(val);
        if (parsed != null) onChanged(parsed);
      },
    );
  }

  void _updateProfile(
    WidgetRef ref,
    UserProfile current, {
    String? defaultCallsign,
    String? defaultOperator,
    String? defaultMySigInfo,
    int? defaultTxPower,
    bool? isDarkTheme,
  }) {
    final updated = UserProfile()
      ..id = current.id
      ..defaultCallsign = defaultCallsign ?? current.defaultCallsign
      ..defaultOperator = defaultOperator ?? current.defaultOperator
      ..defaultMySigInfo = defaultMySigInfo ?? current.defaultMySigInfo
      ..defaultTxPower = defaultTxPower ?? current.defaultTxPower
      ..isDarkTheme = isDarkTheme ?? current.isDarkTheme;

    ref.read(settingsRepositoryProvider).updateProfile(updated);
  }
}
