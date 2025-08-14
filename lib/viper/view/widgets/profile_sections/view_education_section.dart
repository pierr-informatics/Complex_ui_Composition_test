import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewEducationSection extends StatelessWidget {
  final UserProfile profile;

  const ViewEducationSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Education',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...profile.education.map(
          (edu) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edu.institution,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${edu.degree} in ${edu.field}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  _formatWorkPeriod(edu.startDate, edu.endDate),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text('GPA: ${edu.gpa.toStringAsFixed(1)}'),
                if (edu.achievements.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  const Text(
                    'Achievements:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  ...edu.achievements.map(
                    (achievement) => Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 2.0,
                        bottom: 2.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• '),
                          Expanded(child: Text(achievement)),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                if (profile.education.last != edu) const Divider(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatWorkPeriod(DateTime startDate, DateTime? endDate) {
    final start = DateFormat('MMM yyyy').format(startDate);
    final end = endDate != null
        ? DateFormat('MMM yyyy').format(endDate)
        : 'Present';
    return '$start - $end';
  }
}
