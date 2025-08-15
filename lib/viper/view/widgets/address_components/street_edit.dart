import 'package:flutter/material.dart';

class StreetEdit extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const StreetEdit({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Street Address',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.home),
      ),
      onChanged: onChanged,
    );
  }
}
