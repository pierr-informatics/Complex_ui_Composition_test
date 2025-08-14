import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditSkillsSection extends StatefulWidget {
  final UserProfile profile;

  const EditSkillsSection({super.key, required this.profile});

  @override
  State<EditSkillsSection> createState() => _EditSkillsSectionState();
}

class _EditSkillsSectionState extends State<EditSkillsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills', style: Theme.of(context).textTheme.titleLarge),
        ...widget.profile.skillRatings.entries.map((entry) {
          return ListTile(
            title: Text(entry.key),
            trailing: SizedBox(
              width: 150,
              child: Slider(
                value: entry.value.toDouble(),
                min: 0,
                max: 100,
                divisions: 10,
                label: entry.value.toString(),
                onChanged: (value) {
                  setState(() {
                    widget.profile.skillRatings[entry.key] = value.toInt();
                  });
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
