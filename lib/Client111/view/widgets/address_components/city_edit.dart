import 'package:flutter/material.dart';

class CityEdit extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CityEdit({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'City',
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
