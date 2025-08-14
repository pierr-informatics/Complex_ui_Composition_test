import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditAvailabilitySection extends StatefulWidget {
  final UserProfile profile;

  const EditAvailabilitySection({super.key, required this.profile});

  @override
  State<EditAvailabilitySection> createState() =>
      _EditAvailabilitySectionState();
}

class _EditAvailabilitySectionState extends State<EditAvailabilitySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Availability', style: Theme.of(context).textTheme.titleLarge),
        ...widget.profile.availabilityWeekdays.entries.map((entry) {
          return ListTile(
            title: Text(entry.key),
            trailing: SizedBox(
              width: 150,
              child: Slider(
                value: entry.value.toDouble(),
                min: 0,
                max: 24,
                divisions: 24,
                label: entry.value.toString(),
                onChanged: (value) {
                  setState(() {
                    widget.profile.availabilityWeekdays[entry.key] = value
                        .toInt();
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
