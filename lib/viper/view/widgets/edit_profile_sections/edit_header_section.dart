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
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(profile.profileImageUrl),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                onPressed: onImagePick,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
