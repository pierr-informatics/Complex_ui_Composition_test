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
        Text(
          'Certifications',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...widget.profile.certifications.map((cert) {
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.transparent,
            child: ListTile(
              title: Text(
                cert,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() {
                    widget.profile.certifications.remove(cert);
                  });
                },
              ),
            ),
          );
        }),
        OutlinedButton.icon(
          onPressed: _showAddCertificationDialog,
          icon: const Icon(Icons.add),
          label: const Text('Add Certification'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
          ),
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
