import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditPreferencesSection extends StatefulWidget {
  final UserProfile profile;

  const EditPreferencesSection({super.key, required this.profile});

  @override
  State<EditPreferencesSection> createState() => _EditPreferencesSectionState();
}

class _EditPreferencesSectionState extends State<EditPreferencesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferences',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...widget.profile.preferences.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatPreferenceKey(entry.key),
                  style: const TextStyle(fontSize: 16),
                ),
                Switch(
                  value: entry.value,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      widget.profile.preferences[entry.key] = value;
                    });
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  String _formatPreferenceKey(String key) {
    final result = key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return result.substring(0, 1).toUpperCase() + result.substring(1);
  }
}
