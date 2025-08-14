import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewLanguagesSection extends StatelessWidget {
  final UserProfile profile;

  const ViewLanguagesSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Languages',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        profile.languages.isEmpty
            ? const Text('No languages specified')
            : Wrap(
                spacing: 8,
                runSpacing: 4,
                children: profile.languages
                    .map(
                      (lang) => Chip(
                        label: Text(lang),
                        backgroundColor: Colors.blue.shade100,
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }
}
