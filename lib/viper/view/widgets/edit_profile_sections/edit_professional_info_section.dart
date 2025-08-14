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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Professional Information',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _occupationController,
          decoration: const InputDecoration(
            labelText: 'Occupation',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.work),
          ),
          onChanged: (value) => widget.profile.occupation = value,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _companyController,
          decoration: const InputDecoration(
            labelText: 'Company',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.business),
          ),
          onChanged: (value) => widget.profile.companyName = value,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _incomeController,
          decoration: const InputDecoration(
            labelText: 'Annual Income',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.attach_money),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your income';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
          onChanged: (value) {
            widget.profile.income =
                double.tryParse(value) ?? widget.profile.income;
          },
        ),
      ],
    );
  }
}
