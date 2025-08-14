import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewHeaderSection extends StatelessWidget {
  final UserProfile profile;

  const ViewHeaderSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(profile.profileImageUrl),
          ),
          const SizedBox(height: 16),
          Text(
            '${profile.firstName} ${profile.lastName}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            profile.occupation,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            profile.companyName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
