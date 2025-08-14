import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditPersonalInfoSection extends StatefulWidget {
  final UserProfile profile;
  final GlobalKey<FormState> formKey;

  const EditPersonalInfoSection({
    super.key,
    required this.profile,
    required this.formKey,
  });

  @override
  State<EditPersonalInfoSection> createState() =>
      _EditPersonalInfoSectionState();
}

class _EditPersonalInfoSectionState extends State<EditPersonalInfoSection> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.profile.firstName,
    );
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phoneNumber);
    _dobController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(widget.profile.dateOfBirth),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
            onSaved: (value) => widget.profile.firstName = value!,
          ),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
            onSaved: (value) => widget.profile.lastName = value!,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            onSaved: (value) => widget.profile.email = value!,
          ),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Phone Number'),
            onSaved: (value) => widget.profile.phoneNumber = value!,
          ),
          TextFormField(
            controller: _dobController,
            decoration: const InputDecoration(labelText: 'Date of Birth'),
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: widget.profile.dateOfBirth,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(() {
                  widget.profile.dateOfBirth = date;
                  _dobController.text = DateFormat('yyyy-MM-dd').format(date);
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
