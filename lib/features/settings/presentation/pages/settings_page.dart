import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/glass_card.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/models/user_profile.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        scrolledUnderElevation: 0,
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return Center(
              child: Text(
                'No Profile Found',
                style: TextStyle(color: AppColors.subtext(brightness)),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildSectionTitle(context, 'Station Information'),
              const SizedBox(height: 8),
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Column(
                  children: [
                    _buildTextField(
                      context: context,
                      label: 'Default Callsign',
                      initialValue: profile.defaultCallsign ?? '',
                      onChanged: (val) => _updateProfile(ref, profile, defaultCallsign: val),
                      icon: Icons.badge_outlined,
                    ),
                    Divider(
                      height: 1,
                      color: brightness == Brightness.dark
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Default Operator',
                      initialValue: profile.defaultOperator ?? '',
                      onChanged: (val) => _updateProfile(ref, profile, defaultOperator: val),
                      icon: Icons.person_outline,
                    ),
                    Divider(
                      height: 1,
                      color: brightness == Brightness.dark
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                    _buildTextField(
                      context: context,
                      label: 'Current Park (My Sig Info)',
                      initialValue: profile.defaultMySigInfo ?? '',
                      onChanged: (val) => _updateProfile(ref, profile, defaultMySigInfo: val.toUpperCase()),
                      icon: Icons.location_on_outlined,
                      hint: 'e.g. TAFF-0001',
                    ),
                    Divider(
                      height: 1,
                      color: brightness == Brightness.dark
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                    _buildNumberField(
                      context: context,
                      label: 'Default TX Power (W)',
                      initialValue: profile.defaultTxPower ?? 10,
                      onChanged: (val) => _updateProfile(ref, profile, defaultTxPower: val),
                      icon: Icons.bolt_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle(context, 'App Preferences'),
              const SizedBox(height: 8),
              GlassCard(
                padding: EdgeInsets.zero,
                child: SwitchListTile(
                  title: Text(
                    'Dark Theme',
                    style: TextStyle(
                      fontSize: 14,
                      color: brightness == Brightness.dark
                          ? AppColors.darkOnSurface
                          : Colors.black87,
                    ),
                  ),
                  secondary: Icon(
                    Icons.dark_mode_outlined,
                    size: 20,
                    color: AppColors.subtext(brightness),
                  ),
                  value: profile.isDarkTheme,
                  onChanged: (val) => _updateProfile(ref, profile, isDarkTheme: val),
                  activeThumbColor: Theme.of(context).primaryColor,
                  dense: true,
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle(context, 'About'),
              const SizedBox(height: 8),
              GlassCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.forest_rounded,
                        color: AppColors.primaryGreen,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WWFF on the GO',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: brightness == Brightness.dark
                                  ? AppColors.darkOnSurface
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Version 1.0.0',
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
              const SizedBox(height: 100),
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: brightness == Brightness.dark
                      ? AppColors.secondaryGreen
                      : Theme.of(context).primaryColor,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
    required IconData icon,
    String? hint,
  }) {
    final brightness = Theme.of(context).brightness;
    return TextFormField(
      initialValue: initialValue,
      style: TextStyle(
        fontSize: 14,
        color: brightness == Brightness.dark
            ? AppColors.darkOnSurface
            : Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 12,
          color: AppColors.subtext(brightness),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.subtext(brightness).withValues(alpha: 0.5),
        ),
        prefixIcon: Icon(
          icon,
          size: 20,
          color: AppColors.subtext(brightness),
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        filled: false,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildNumberField({
    required BuildContext context,
    required String label,
    required int initialValue,
    required ValueChanged<int> onChanged,
    required IconData icon,
  }) {
    final brightness = Theme.of(context).brightness;
    return TextFormField(
      initialValue: initialValue.toString(),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 14,
        color: brightness == Brightness.dark
            ? AppColors.darkOnSurface
            : Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 12,
          color: AppColors.subtext(brightness),
        ),
        prefixIcon: Icon(
          icon,
          size: 20,
          color: AppColors.subtext(brightness),
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        filled: false,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
