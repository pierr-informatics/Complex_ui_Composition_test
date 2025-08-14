import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';
import 'package:complex_ui/viper/entity/education.dart';

class EditEducationSection extends StatefulWidget {
  final UserProfile profile;

  const EditEducationSection({super.key, required this.profile});

  @override
  State<EditEducationSection> createState() => _EditEducationSectionState();
}

class _EditEducationSectionState extends State<EditEducationSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Education', style: Theme.of(context).textTheme.titleLarge),
        ...widget.profile.education.map((edu) {
          return ListTile(
            title: Text(edu.institution),
            subtitle: Text(
              '${edu.degree} · ${DateFormat('yyyy').format(edu.endDate!)}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.profile.education.remove(edu);
                });
              },
            ),
          );
        }),
        ElevatedButton(
          onPressed: _showAddEducationDialog,
          child: const Text('Add Education'),
        ),
      ],
    );
  }

  void _showAddEducationDialog() {
    final institutionController = TextEditingController();
    final degreeController = TextEditingController();
    DateTime? completionDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Education'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: institutionController,
                decoration: const InputDecoration(hintText: 'Institution'),
              ),
              TextField(
                controller: degreeController,
                decoration: const InputDecoration(hintText: 'Degree'),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      completionDate == null
                          ? 'Completion Date'
                          : DateFormat('yyyy-MM-dd').format(completionDate!),
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
                          completionDate = date;
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
                if (institutionController.text.isNotEmpty &&
                    degreeController.text.isNotEmpty &&
                    completionDate != null) {
                  setState(() {
                    widget.profile.education.add(
                      Education(
                        institution: institutionController.text,
                        degree: degreeController.text,
                        field: '',
                        startDate: DateTime.now(),
                        endDate: completionDate,
                        gpa: 0.0,
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
