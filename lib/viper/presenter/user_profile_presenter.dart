import 'package:flutter/material.dart';
import '../entity/user_profile.dart';
import '../interactor/user_profile_interactor.dart';

class UserProfilePresenter {
  final UserProfileInteractor _interactor;

  // State management
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);
  ValueNotifier<UserProfile?> userProfile = ValueNotifier<UserProfile?>(null);

  UserProfilePresenter(this._interactor);

  Future<void> loadUserProfile() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final profile = await _interactor.getUserProfile();
      userProfile.value = profile;
    } catch (e) {
      errorMessage.value = 'Failed to load user profile: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> saveUserProfile(UserProfile profile) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final result = await _interactor.updateUserProfile(profile);
      if (result) {
        userProfile.value = profile;
      }
      return result;
    } catch (e) {
      errorMessage.value = 'Failed to save user profile: ${e.toString()}';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  bool validateForm(UserProfile profile) {
    if (profile.firstName.isEmpty || profile.lastName.isEmpty) {
      errorMessage.value = 'Name fields cannot be empty';
      return false;
    }

    if (!_interactor.validateEmail(profile.email)) {
      errorMessage.value = 'Please enter a valid email address';
      return false;
    }

    if (!_interactor.validatePhoneNumber(profile.phoneNumber)) {
      errorMessage.value = 'Please enter a valid phone number';
      return false;
    }

    if (!_interactor.validateZipCode(profile.zipCode)) {
      errorMessage.value = 'Please enter a valid ZIP code';
      return false;
    }

    return true;
  }

  String getFullName() {
    return userProfile.value != null
        ? _interactor.getFullName(userProfile.value!)
        : '';
  }

  int getAge() {
    return userProfile.value != null
        ? _interactor.getAge(userProfile.value!)
        : 0;
  }

  Future<void> updatePreference(String key, bool value) async {
    if (userProfile.value != null) {
      final updatedProfile = userProfile.value!;
      updatedProfile.preferences[key] = value;
      await saveUserProfile(updatedProfile);
    }
  }
  
  void dispose() {
    isLoading.dispose();
    errorMessage.dispose();
    userProfile.dispose();
  }
}
