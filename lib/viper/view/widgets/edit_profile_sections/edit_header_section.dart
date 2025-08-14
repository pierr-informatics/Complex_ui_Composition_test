import 'package:flutter/material.dart';
import 'package:complex_ui/viper/entity/user_profile.dart';

class EditHeaderSection extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onImagePick;

  const EditHeaderSection({
    super.key,
    required this.profile,
    required this.onImagePick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(profile.profileImageUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: onImagePick,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${profile.firstName} ${profile.lastName}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(profile.email, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 24),
      ],
    );
  }
}
