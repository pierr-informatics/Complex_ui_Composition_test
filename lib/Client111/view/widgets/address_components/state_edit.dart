import 'package:flutter/material.dart';

class StateEdit extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const StateEdit({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'State',
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
