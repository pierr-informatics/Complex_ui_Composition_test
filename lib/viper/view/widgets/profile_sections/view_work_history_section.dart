import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewWorkHistorySection extends StatelessWidget {
  final UserProfile profile;

  const ViewWorkHistorySection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Work History', style: Theme.of(context).textTheme.titleLarge),
            ...profile.workExperience.map(
              (job) => ListTile(
                title: Text(job.position),
                subtitle: Text(
                  '${job.companyName} · ${_formatWorkPeriod(job.startDate, job.endDate)}',
                ),
              ),
            ),
          ],
        ),
      ),
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
