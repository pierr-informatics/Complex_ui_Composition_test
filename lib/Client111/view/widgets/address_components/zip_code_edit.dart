import 'package:flutter/material.dart';

class ZipCodeEdit extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const ZipCodeEdit({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'ZIP Code',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        if (value.length != 5 || int.tryParse(value) == null) {
          return 'Invalid ZIP';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
