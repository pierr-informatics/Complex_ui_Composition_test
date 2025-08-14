import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewSkillsSection extends StatelessWidget {
  final UserProfile profile;

  const ViewSkillsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...profile.skillRatings.entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${entry.value}%'),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: entry.value / 100,
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getColorForSkillLevel(entry.value),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getColorForSkillLevel(int level) {
    if (level >= 90) return Colors.green;
    if (level >= 75) return Colors.blue;
    if (level >= 60) return Colors.orange;
    return Colors.red;
  }
}
