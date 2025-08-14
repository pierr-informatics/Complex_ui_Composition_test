import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';
import 'package:complex_ui/viper/entity/work_experience.dart';

class EditWorkHistorySection extends StatefulWidget {
  final UserProfile profile;

  const EditWorkHistorySection({super.key, required this.profile});

  @override
  State<EditWorkHistorySection> createState() => _EditWorkHistorySectionState();
}

class _EditWorkHistorySectionState extends State<EditWorkHistorySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Work History', style: Theme.of(context).textTheme.titleLarge),
        ...widget.profile.workExperience.map((job) {
          return ListTile(
            title: Text(job.position),
            subtitle: Text(
              '${job.companyName} · ${_formatWorkPeriod(job.startDate, job.endDate)}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.profile.workExperience.remove(job);
                });
              },
            ),
          );
        }),
        ElevatedButton(
          onPressed: _showAddWorkExperienceDialog,
          child: const Text('Add Work Experience'),
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

  void _showAddWorkExperienceDialog() {
    final jobTitleController = TextEditingController();
    final companyController = TextEditingController();
    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Work Experience'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: jobTitleController,
                decoration: const InputDecoration(hintText: 'Job Title'),
              ),
              TextField(
                controller: companyController,
                decoration: const InputDecoration(hintText: 'Company'),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      startDate == null
                          ? 'Start Date'
                          : DateFormat('yyyy-MM-dd').format(startDate!),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          startDate = date;
                        });
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      endDate == null
                          ? 'End Date'
                          : DateFormat('yyyy-MM-dd').format(endDate!),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          endDate = date;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (jobTitleController.text.isNotEmpty &&
                    companyController.text.isNotEmpty &&
                    startDate != null) {
                  setState(() {
                    widget.profile.workExperience.add(
                      WorkExperience(
                        position: jobTitleController.text,
                        companyName: companyController.text,
                        startDate: startDate!,
                        endDate: endDate,
                        description: '',
                        achievements: [],
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
