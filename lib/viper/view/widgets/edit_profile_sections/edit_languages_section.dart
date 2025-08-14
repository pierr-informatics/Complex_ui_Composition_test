import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditLanguagesSection extends StatefulWidget {
  final UserProfile profile;

  const EditLanguagesSection({super.key, required this.profile});

  @override
  State<EditLanguagesSection> createState() => _EditLanguagesSectionState();
}

class _EditLanguagesSectionState extends State<EditLanguagesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Languages', style: Theme.of(context).textTheme.titleLarge),
        ...widget.profile.languages.map((lang) {
          return ListTile(
            title: Text(lang),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.profile.languages.remove(lang);
                });
              },
            ),
          );
        }),
        ElevatedButton(
          onPressed: _showAddLanguageDialog,
          child: const Text('Add Language'),
        ),
      ],
    );
  }

  void _showAddLanguageDialog() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Language'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Enter language'),
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
                    widget.profile.languages.add(textController.text);
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
