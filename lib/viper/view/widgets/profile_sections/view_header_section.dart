import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class ViewHeaderSection extends StatelessWidget {
  final UserProfile profile;

  const ViewHeaderSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(profile.profileImageUrl),
        ),
        const SizedBox(height: 16),
        Text(
          '${profile.firstName} ${profile.lastName}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          profile.occupation,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
