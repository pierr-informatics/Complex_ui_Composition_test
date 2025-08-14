import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';
import 'package:complex_ui/viper/presenter/user_profile_presenter.dart';

class ViewPreferencesSection extends StatelessWidget {
  final UserProfile profile;
  final UserProfilePresenter presenter;

  const ViewPreferencesSection({
    super.key,
    required this.profile,
    required this.presenter,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preferences', style: Theme.of(context).textTheme.titleLarge),
            ...profile.preferences.entries.map((entry) {
              return SwitchListTile(
                title: Text(_formatPreferenceKey(entry.key)),
                value: entry.value,
                onChanged: (bool value) {
                  presenter.updatePreference(entry.key, value);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _formatPreferenceKey(String key) {
    // Convert camelCase to words with first letter capitalized
    final result = key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return result.substring(0, 1).toUpperCase() + result.substring(1);
  }
}
