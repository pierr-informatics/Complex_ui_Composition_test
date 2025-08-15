import 'package:flutter/material.dart';

class ZipCodeView extends StatelessWidget {
  final String zipCode;

  const ZipCodeView({super.key, required this.zipCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              'ZIP Code:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(zipCode)),
        ],
      ),
    );
  }
}
