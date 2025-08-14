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

            double income = double.parse(value);
            if (income < 50000 || income > 200000) {
              // Showing an immediate dialog is not possible in validator
              // We'll mark it as error and handle the dialog elsewhere
              return 'Value must be between 50000 and 200000';
            }
            return null;
          },
          onChanged: (value) {
            double? parsedValue = double.tryParse(value);
            if (parsedValue != null) {
              widget.profile.income = parsedValue;

              // Check if the value is outside the valid range
              if (parsedValue < 50000 || parsedValue > 200000) {
                // Use a post-frame callback to show dialog after the build completes
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        children: [
                          Icon(Icons.warning, color: Colors.amber),
                          SizedBox(width: 10),
                          Text('Invalid Income'),
                        ],
                      ),
                      content: Text(
                        'Annual income must be between \$50,000 and \$200,000.',
                        style: TextStyle(fontSize: 16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              }
            } else {
              widget.profile.income = widget.profile.income;
            }
          },
        ),
      ],
    );
  }
}
