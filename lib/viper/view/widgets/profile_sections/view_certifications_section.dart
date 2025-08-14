import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewCertificationsSection extends StatelessWidget {
  final UserProfile profile;

  const ViewCertificationsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Certifications',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ...profile.certifications
                .map(
                  (cert) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('• $cert'),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
