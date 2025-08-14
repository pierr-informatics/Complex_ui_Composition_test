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
        Text(
          'Availability',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...widget.profile.availabilityWeekdays.entries.map((entry) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key, style: const TextStyle(fontSize: 16)),
                  Text(
                    '${entry.value}h',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.blue,
                  thumbColor: Colors.blue,
                  trackHeight: 4.0,
                ),
                child: Slider(
                  value: entry.value.toDouble(),
                  min: 0,
                  max: 24,
                  divisions: 24,
                  onChanged: (value) {
                    setState(() {
                      widget.profile.availabilityWeekdays[entry.key] = value
                          .toInt();
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        }),
      ],
    );
  }
}
