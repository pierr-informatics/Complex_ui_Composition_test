import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';
import 'package:intl/intl.dart';

class EditAdditionalInfoSection extends StatefulWidget {
  final UserProfile profile;

  const EditAdditionalInfoSection({
    super.key,
    required this.profile,
  });

  @override
  State<EditAdditionalInfoSection> createState() => _EditAdditionalInfoSectionState();
}

class _EditAdditionalInfoSectionState extends State<EditAdditionalInfoSection> {
  late String _selectedGender;
  late String _selectedEmploymentType;
  late String _selectedContactMethod;
  late DateTime _availabilityDate;
  late TextEditingController _expectedSalaryController;
  late TextEditingController _yearsOfExperienceController;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.profile.gender.isNotEmpty ? widget.profile.gender : 'Male';
    _selectedEmploymentType = widget.profile.employmentType.isNotEmpty ? widget.profile.employmentType : 'Full-time';
    _selectedContactMethod = widget.profile.preferredContactMethod.isNotEmpty ? widget.profile.preferredContactMethod : 'Email';
    _availabilityDate = widget.profile.availabilityDate;
    _expectedSalaryController = TextEditingController(text: widget.profile.expectedSalary.toString());
    _yearsOfExperienceController = TextEditingController(text: widget.profile.yearsOfExperience.toString());
  }

  @override
  void dispose() {
    _expectedSalaryController.dispose();
    _yearsOfExperienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Gender Dropdown
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Gender',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
          value: _selectedGender,
          isExpanded: true,
          items: ['Male', 'Female', 'Non-binary', 'Prefer not to say'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedGender = newValue;
                widget.profile.gender = newValue;
              });
            }
          },
        ),
        const SizedBox(height: 16),

        // Employment Type
        const Text(
          'Employment Type',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment<String>(
              value: 'Full-time',
              label: Text('Full-time'),
              icon: Icon(Icons.work),
            ),
            ButtonSegment<String>(
              value: 'Part-time',
              label: Text('Part-time'),
              icon: Icon(Icons.work_outline),
            ),
            ButtonSegment<String>(
              value: 'Contract',
              label: Text('Contract'),
              icon: Icon(Icons.description),
            ),
            ButtonSegment<String>(
              value: 'Freelance',
              label: Text('Freelance'),
              icon: Icon(Icons.person_outline),
            ),
          ],
          selected: {_selectedEmploymentType},
          onSelectionChanged: (Set<String> newSelection) {
            setState(() {
              _selectedEmploymentType = newSelection.first;
              widget.profile.employmentType = newSelection.first;
            });
          },
        ),
        const SizedBox(height: 16),

        // Availability Date Picker
        InkWell(
          onTap: () => _selectAvailabilityDate(context),
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Availability Date',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.event_available),
            ),
            child: Text(DateFormat('yyyy-MM-dd').format(_availabilityDate)),
          ),
        ),
        const SizedBox(height: 16),

        // Expected Salary
        TextFormField(
          controller: _expectedSalaryController,
          decoration: InputDecoration(
            labelText: 'Expected Salary (\$${widget.profile.expectedSalary.toStringAsFixed(0)})',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.monetization_on),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              widget.profile.expectedSalary = double.tryParse(value) ?? widget.profile.expectedSalary;
            });
          },
        ),
        Slider(
          min: 50000,
          max: 200000,
          divisions: 15,
          value: widget.profile.expectedSalary,
          label: '\$${widget.profile.expectedSalary.toStringAsFixed(0)}',
          onChanged: (value) {
            setState(() {
              widget.profile.expectedSalary = value;
              _expectedSalaryController.text = value.toStringAsFixed(0);
            });
          },
        ),
        const SizedBox(height: 16),

        // Years of Experience
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _yearsOfExperienceController,
                decoration: const InputDecoration(
                  labelText: 'Years of Experience',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timeline),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  widget.profile.yearsOfExperience = int.tryParse(value) ?? widget.profile.yearsOfExperience;
                },
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      widget.profile.yearsOfExperience++;
                      _yearsOfExperienceController.text = widget.profile.yearsOfExperience.toString();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (widget.profile.yearsOfExperience > 0) {
                        widget.profile.yearsOfExperience--;
                        _yearsOfExperienceController.text = widget.profile.yearsOfExperience.toString();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Preferred Contact Method Radio Buttons
        const Text(
          'Preferred Contact Method',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        RadioListTile<String>(
          title: const Text('Email'),
          value: 'Email',
          groupValue: _selectedContactMethod,
          onChanged: (value) {
            setState(() {
              _selectedContactMethod = value!;
              widget.profile.preferredContactMethod = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Phone'),
          value: 'Phone',
          groupValue: _selectedContactMethod,
          onChanged: (value) {
            setState(() {
              _selectedContactMethod = value!;
              widget.profile.preferredContactMethod = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Text Message'),
          value: 'Text Message',
          groupValue: _selectedContactMethod,
          onChanged: (value) {
            setState(() {
              _selectedContactMethod = value!;
              widget.profile.preferredContactMethod = value;
            });
          },
        ),
        const SizedBox(height: 16),

        // Remote Work and Relocation Checkboxes
        CheckboxListTile(
          title: const Text('Eligible for Remote Work'),
          subtitle: const Text('Can work fully remote'),
          value: widget.profile.isRemoteWorkEligible,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                widget.profile.isRemoteWorkEligible = value;
              });
            }
          },
        ),
        CheckboxListTile(
          title: const Text('Willing to Relocate'),
          subtitle: const Text('Open to moving for the right position'),
          value: widget.profile.isWillingToRelocate,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                widget.profile.isWillingToRelocate = value;
              });
            }
          },
        ),
      ],
    );
  }

  Future<void> _selectAvailabilityDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _availabilityDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _availabilityDate) {
      setState(() {
        _availabilityDate = picked;
        widget.profile.availabilityDate = picked;
      });
    }
  }
}
