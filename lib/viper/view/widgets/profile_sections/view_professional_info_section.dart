import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewProfessionalInfoSection extends StatelessWidget {
  final UserProfile profile;

  const ViewProfessionalInfoSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Professional Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            _buildInfoItem('Company', profile.companyName),
            _buildInfoItem(
              'Years of Experience',
              '${profile.yearsOfExperience}',
            ),
            _buildInfoItem('Income', '\$${profile.income.toStringAsFixed(2)}'),
            _buildInfoItem(
              'Expected Salary',
              '\$${profile.expectedSalary.toStringAsFixed(2)}',
            ),
            _buildInfoItem('Employment Type', profile.employmentType),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
