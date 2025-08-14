import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';
import 'package:complex_ui/viper/presenter/user_profile_presenter.dart';

class ViewPersonalInfoSection extends StatelessWidget {
  final UserProfile profile;
  final UserProfilePresenter presenter;

  const ViewPersonalInfoSection({
    super.key,
    required this.profile,
    required this.presenter,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            _buildInfoItem('Email', profile.email),
            _buildInfoItem('Phone', profile.phoneNumber),
            _buildInfoItem(
              'Date of Birth',
              DateFormat('yyyy-MM-dd').format(profile.dateOfBirth),
            ),
            _buildInfoItem('Age', presenter.getAge().toString()),
            _buildInfoItem('Gender', profile.gender),
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
