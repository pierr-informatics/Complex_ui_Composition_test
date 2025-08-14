import 'package:flutter/material.dart';

class ProfileWidgets {
  static Widget interestChip(String label, VoidCallback? onDelete) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close),
      onDeleted: onDelete,
    );
  }

  static Widget addInterestChip(VoidCallback onPressed) {
    return ActionChip(
      avatar: const Icon(Icons.add),
      label: const Text('Add Interest'),
      onPressed: onPressed,
    );
  }
}
