import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewInterestsSection extends StatelessWidget {
  final UserProfile profile;

  const ViewInterestsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Interests', style: Theme.of(context).textTheme.titleLarge),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: profile.interests
                  .map((interest) => Chip(label: Text(interest)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
