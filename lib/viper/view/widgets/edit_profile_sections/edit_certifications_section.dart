import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditCertificationsSection extends StatefulWidget {
  final UserProfile profile;

  const EditCertificationsSection({super.key, required this.profile});

  @override
  State<EditCertificationsSection> createState() =>
      _EditCertificationsSectionState();
}

class _EditCertificationsSectionState extends State<EditCertificationsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Certifications', style: Theme.of(context).textTheme.titleLarge),
        ...widget.profile.certifications.map((cert) {
          return ListTile(
            title: Text(cert),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.profile.certifications.remove(cert);
                });
              },
            ),
          );
        }),
        ElevatedButton(
          onPressed: _showAddCertificationDialog,
          child: const Text('Add Certification'),
        ),
      ],
    );
  }

  void _showAddCertificationDialog() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Certification'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Enter certification'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  setState(() {
                    widget.profile.certifications.add(textController.text);
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
