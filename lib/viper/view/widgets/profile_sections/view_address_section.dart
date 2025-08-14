import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewAddressSection extends StatelessWidget {
  final UserProfile profile;

  const ViewAddressSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address', style: Theme.of(context).textTheme.titleLarge),
            _buildInfoItem('Address', profile.address),
            _buildInfoItem('City', profile.city),
            _buildInfoItem('State', profile.state),
            _buildInfoItem('ZIP Code', profile.zipCode),
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
