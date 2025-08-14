import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewAvailabilitySection extends StatelessWidget {
  final UserProfile profile;

  const ViewAvailabilitySection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Availability', style: Theme.of(context).textTheme.titleLarge),
            _buildInfoItem(
              'Available From',
              DateFormat('yyyy-MM-dd').format(profile.availabilityDate),
            ),
            const SizedBox(height: 8),
            ...profile.availabilityWeekdays.entries.map(
              (day) => _buildInfoItem(day.key, '${day.value} hours'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
