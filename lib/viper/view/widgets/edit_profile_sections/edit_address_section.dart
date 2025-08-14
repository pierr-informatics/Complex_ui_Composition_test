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
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Address', style: Theme.of(context).textTheme.titleLarge),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Address'),
            onSaved: (value) => widget.profile.address = value!,
          ),
          TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(labelText: 'City'),
            onSaved: (value) => widget.profile.city = value!,
          ),
          TextFormField(
            controller: _stateController,
            decoration: const InputDecoration(labelText: 'State'),
            onSaved: (value) => widget.profile.state = value!,
          ),
          TextFormField(
            controller: _zipController,
            decoration: const InputDecoration(labelText: 'Zip Code'),
            onSaved: (value) => widget.profile.zipCode = value!,
          ),
        ],
      ),
    );
  }
}
