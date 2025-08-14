import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditInterestsSection extends StatefulWidget {
  final UserProfile profile;

  const EditInterestsSection({super.key, required this.profile});

  @override
  State<EditInterestsSection> createState() => _EditInterestsSectionState();
}

class _EditInterestsSectionState extends State<EditInterestsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Interests', style: Theme.of(context).textTheme.titleLarge),
        Wrap(
          spacing: 8.0,
          children: widget.profile.interests.map((interest) {
            return Chip(
              label: Text(interest),
              onDeleted: () {
                setState(() {
                  widget.profile.interests.remove(interest);
                });
              },
            );
          }).toList(),
        ),
        ElevatedButton(
          onPressed: _showAddInterestDialog,
          child: const Text('Add Interest'),
        ),
      ],
    );
  }

  void _showAddInterestDialog() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Interest'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Enter interest'),
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
                    widget.profile.interests.add(textController.text);
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
