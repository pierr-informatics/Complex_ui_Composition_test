import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewSkillsSection extends StatelessWidget {
  final UserProfile profile;

  const ViewSkillsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Skills', style: Theme.of(context).textTheme.titleLarge),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: profile.skillRatings.entries
                  .map(
                    (skill) => Chip(
                      label: Text('${skill.key} (${skill.value}%)'),
                      backgroundColor: _getColorForSkillLevel(skill.value),
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForSkillLevel(int level) {
    if (level >= 90) return Colors.green;
    if (level >= 75) return Colors.blue;
    if (level >= 60) return Colors.orange;
    return Colors.red;
  }
}
