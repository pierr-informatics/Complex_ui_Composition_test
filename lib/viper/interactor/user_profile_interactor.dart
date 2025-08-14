import '../entity/user_profile.dart';
import '../entity/user_profile_repository.dart';

class UserProfileInteractor {
  final UserProfileRepository _repository;

  UserProfileInteractor(this._repository);

  Future<UserProfile> getUserProfile() async {
    return await _repository.getUserProfile();
  }

  Future<bool> updateUserProfile(UserProfile profile) async {
    return await _repository.updateUserProfile(profile);
  }

  bool validateEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  bool validatePhoneNumber(String phoneNumber) {
    // Very basic validation - in a real app this should be more comprehensive
    return phoneNumber.length >= 10;
  }

  bool validateZipCode(String zipCode) {
    // US ZIP code validation
    return zipCode.length == 5 && int.tryParse(zipCode) != null;
  }

  String getFullName(UserProfile profile) {
    return '${profile.firstName} ${profile.lastName}';
  }

  int getAge(UserProfile profile) {
    final now = DateTime.now();
    int age = now.year - profile.dateOfBirth.year;
    if (now.month < profile.dateOfBirth.month ||
        (now.month == profile.dateOfBirth.month &&
            now.day < profile.dateOfBirth.day)) {
      age--;
    }
    return age;
  }
}
