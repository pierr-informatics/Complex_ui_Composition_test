import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';
import 'package:intl/intl.dart';

class ViewProfessionalInfoSection extends StatelessWidget {
  final UserProfile profile;

  const ViewProfessionalInfoSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professional Information',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoItem('Occupation', profile.occupation),
          _buildInfoItem('Company', profile.companyName),
          _buildInfoItem(
            'Annual Income',
            '\$${NumberFormat('#,##0.00').format(profile.income)}',
          ),
          _buildInfoItem(
            'Employment Type',
            profile.employmentType.isEmpty
                ? 'Not specified'
                : profile.employmentType,
          ),
          _buildInfoItem(
            'Years of Experience',
            profile.yearsOfExperience.toString(),
          ),
          _buildInfoItem(
            'Expected Salary',
            '\$${NumberFormat('#,##0.00').format(profile.expectedSalary)}',
          ),
          _buildInfoItem(
            'Available From',
            DateFormat('yyyy-MM-dd').format(profile.availabilityDate),
          ),
          _buildInfoItem(
            'Remote Work Eligible',
            profile.isRemoteWorkEligible ? 'Yes' : 'No',
          ),
          _buildInfoItem(
            'Willing to Relocate',
            profile.isWillingToRelocate ? 'Yes' : 'No',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
