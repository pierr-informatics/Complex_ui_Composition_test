import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditSkillsSection extends StatefulWidget {
  final UserProfile profile;

  const EditSkillsSection({super.key, required this.profile});

  @override
  State<EditSkillsSection> createState() => _EditSkillsSectionState();
}

class _EditSkillsSectionState extends State<EditSkillsSection> {
  late TextEditingController _newSkillController;
  final Map<String, int> _skillRatings = {};
  bool _isAddingSkill = false;

  @override
  void initState() {
    super.initState();
    _newSkillController = TextEditingController();
    // Copy skills to local map for editing
    _skillRatings.addAll(widget.profile.skillRatings);
  }

  @override
  void dispose() {
    _newSkillController.dispose();
    super.dispose();
  }

  Color _getColorForSkillLevel(int level) {
    if (level >= 90) return Colors.green;
    if (level >= 75) return Colors.blue;
    if (level >= 60) return Colors.orange;
    if (level >= 40) return Colors.amber;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Existing skills with sliders
            ..._skillRatings.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text('${entry.value}%'),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _skillRatings.remove(entry.key);
                              widget.profile.skillRatings.remove(entry.key);
                            });
                          },
                          tooltip: 'Remove skill',
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: entry.value.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 20,
                            label: entry.value.toString(),
                            activeColor: _getColorForSkillLevel(entry.value),
                            onChanged: (value) {
                              setState(() {
                                _skillRatings[entry.key] = value.toInt();
                                widget.profile.skillRatings[entry.key] = value
                                    .toInt();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Add new skill section
            if (_isAddingSkill)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _newSkillController,
                        decoration: const InputDecoration(
                          labelText: 'Skill name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_newSkillController.text.isNotEmpty) {
                          setState(() {
                            final newSkill = _newSkillController.text.trim();
                            _skillRatings[newSkill] = 50; // Default to 50%
                            widget.profile.skillRatings[newSkill] = 50;
                            _newSkillController.clear();
                            _isAddingSkill = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Add'),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          _newSkillController.clear();
                          _isAddingSkill = false;
                        });
                      },
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Skill'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isAddingSkill = true;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
