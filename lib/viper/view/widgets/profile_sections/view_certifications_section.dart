import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewCertificationsSection extends StatelessWidget {
  final UserProfile profile;

  const ViewCertificationsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Certifications',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          profile.certifications.isEmpty
              ? const Text('No certifications added')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: profile.certifications
                      .map(
                        (cert) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.verified, color: Colors.green),
                              const SizedBox(width: 8),
                              Text(
                                cert,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}
