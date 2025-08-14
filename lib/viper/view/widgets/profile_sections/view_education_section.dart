import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewEducationSection extends StatelessWidget {
  final UserProfile profile;

  const ViewEducationSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Education', style: Theme.of(context).textTheme.titleLarge),
            ...profile.education
                .map(
                  (edu) => ListTile(
                    title: Text(edu.degree),
                    subtitle: Text(
                      '${edu.institution} · ${DateFormat('yyyy').format(edu.endDate!)}',
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
