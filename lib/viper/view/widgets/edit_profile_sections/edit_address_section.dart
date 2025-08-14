import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditAddressSection extends StatefulWidget {
  final UserProfile profile;
  final GlobalKey<FormState> formKey;

  const EditAddressSection({
    super.key,
    required this.profile,
    required this.formKey,
  });

  @override
  State<EditAddressSection> createState() => _EditAddressSectionState();
}

class _EditAddressSectionState extends State<EditAddressSection> {
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.profile.address);
    _cityController = TextEditingController(text: widget.profile.city);
    _stateController = TextEditingController(text: widget.profile.state);
    _zipController = TextEditingController(text: widget.profile.zipCode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _addressController,
          decoration: const InputDecoration(
            labelText: 'Street Address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.home),
          ),
          onChanged: (value) => widget.profile.address = value,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => widget.profile.city = value,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => widget.profile.state = value,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _zipController,
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
                onChanged: (value) => widget.profile.zipCode = value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
