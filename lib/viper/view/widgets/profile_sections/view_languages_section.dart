import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewLanguagesSection extends StatelessWidget {
  final UserProfile profile;

  const ViewLanguagesSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Languages', style: Theme.of(context).textTheme.titleLarge),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: profile.languages
                  .map((lang) => Chip(label: Text(lang)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
