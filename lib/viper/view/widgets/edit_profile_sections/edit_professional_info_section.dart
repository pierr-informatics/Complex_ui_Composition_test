import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditProfessionalInfoSection extends StatefulWidget {
  final UserProfile profile;
  final GlobalKey<FormState> formKey;

  const EditProfessionalInfoSection({
    super.key,
    required this.profile,
    required this.formKey,
  });

  @override
  State<EditProfessionalInfoSection> createState() =>
      _EditProfessionalInfoSectionState();
}

class _EditProfessionalInfoSectionState
    extends State<EditProfessionalInfoSection> {
  late TextEditingController _occupationController;
  late TextEditingController _companyController;
  late TextEditingController _incomeController;

  @override
  void initState() {
    super.initState();
    _occupationController = TextEditingController(
      text: widget.profile.occupation,
    );
    _companyController = TextEditingController(
      text: widget.profile.companyName,
    );
    _incomeController = TextEditingController(
      text: widget.profile.income.toString(),
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
            'Professional Information',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextFormField(
            controller: _occupationController,
            decoration: const InputDecoration(labelText: 'Occupation'),
            onSaved: (value) => widget.profile.occupation = value!,
          ),
          TextFormField(
            controller: _companyController,
            decoration: const InputDecoration(labelText: 'Company'),
            onSaved: (value) => widget.profile.companyName = value!,
          ),
          TextFormField(
            controller: _incomeController,
            decoration: const InputDecoration(labelText: 'Income'),
            keyboardType: TextInputType.number,
            onSaved: (value) => widget.profile.income = double.parse(value!),
          ),
        ],
      ),
    );
  }
}
