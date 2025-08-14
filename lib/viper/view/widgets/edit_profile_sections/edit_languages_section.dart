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
        Text(
          'Languages',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...widget.profile.languages.map((lang) {
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.transparent,
            child: ListTile(
              title: Text(
                lang,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() {
                    widget.profile.languages.remove(lang);
                  });
                },
              ),
            ),
          );
        }),
        OutlinedButton.icon(
          onPressed: _showAddLanguageDialog,
          icon: const Icon(Icons.add),
          label: const Text('Add Language'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
          ),
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
