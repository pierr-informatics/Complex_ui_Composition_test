import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_address_section.dart';
import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_additional_info_section.dart';
import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_availability_section.dart';
import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_certifications_section.dart';
import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_header_section.dart';
import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_interests_section.dart';
import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_languages_section.dart';
import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_personal_info_section.dart';
import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_preferences_section.dart';
import 'package:complex_ui/viper/view/widgets/edit_profile_sections/edit_professional_info_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_address_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_availability_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_certifications_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_education_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_header_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_interests_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_languages_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_personal_info_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_preferences_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_professional_info_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_skills_section.dart';
import 'package:complex_ui/viper/view/widgets/profile_sections/view_work_history_section.dart';
import 'package:flutter/material.dart';
import '../entity/user_profile.dart';
import '../presenter/user_profile_presenter.dart';

class UserProfileView extends StatefulWidget {
  final UserProfilePresenter presenter;

  const UserProfileView({super.key, required this.presenter});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late UserProfile _tempProfile;
  final _formKey = GlobalKey<FormState>();
  bool _isEditMode = false;

  // Form controllers
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipController;
  late TextEditingController _occupationController;
  late TextEditingController _companyController;
  late TextEditingController _incomeController;
  late TextEditingController _expectedSalaryController;
  late TextEditingController _yearsOfExperienceController;

  // Date selections
  late DateTime _selectedDate;
  late DateTime _availabilityDate;

  // Dropdown and multi-select values
  String _selectedGender = '';
  String _selectedEmploymentType = '';
  String _selectedContactMethod = '';
  List<String> _selectedLanguages = [];
  List<String> _selectedCertifications = [];
  Map<String, int> _weekdayHours = {};

  @override
  void initState() {
    super.initState();
    widget.presenter.loadUserProfile();

    // Initialize controllers with default values
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _zipController = TextEditingController();
    _occupationController = TextEditingController();
    _companyController = TextEditingController();
    _incomeController = TextEditingController();
    _expectedSalaryController = TextEditingController();
    _yearsOfExperienceController = TextEditingController();

    // Initialize dates
    _selectedDate = DateTime.now();
    _availabilityDate = DateTime.now().add(const Duration(days: 30));

    // Initialize selection values
    _weekdayHours = {
      'Monday': 8,
      'Tuesday': 8,
      'Wednesday': 8,
      'Thursday': 8,
      'Friday': 8,
      'Saturday': 0,
      'Sunday': 0,
    };
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _occupationController.dispose();
    _companyController.dispose();
    _incomeController.dispose();
    _expectedSalaryController.dispose();
    _yearsOfExperienceController.dispose();
    widget.presenter.dispose();
    super.dispose();
  }

  void _updateControllersFromProfile(UserProfile profile) {
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _emailController.text = profile.email;
    _phoneController.text = profile.phoneNumber;
    _addressController.text = profile.address;
    _cityController.text = profile.city;
    _stateController.text = profile.state;
    _zipController.text = profile.zipCode;
    _occupationController.text = profile.occupation;
    _companyController.text = profile.companyName;
    _incomeController.text = profile.income.toString();
    _expectedSalaryController.text = profile.expectedSalary.toString();
    _yearsOfExperienceController.text = profile.yearsOfExperience.toString();

    // Update dates
    _selectedDate = profile.dateOfBirth;
    _availabilityDate = profile.availabilityDate;

    // Update selection values
    _selectedGender = profile.gender;
    _selectedEmploymentType = profile.employmentType;
    _selectedContactMethod = profile.preferredContactMethod;
    _selectedLanguages = List<String>.from(profile.languages);
    _selectedCertifications = List<String>.from(profile.certifications);
    _weekdayHours = Map<String, int>.from(profile.availabilityWeekdays);
  }

  void _toggleEditMode() {
    setState(() {
      if (_isEditMode) {
        // Switching from edit to view mode
        if (_formKey.currentState?.validate() ?? false) {
          _saveProfile();
        }
      } else {
        // Switching from view to edit mode
        _tempProfile = widget.presenter.userProfile.value!;
        _updateControllersFromProfile(_tempProfile);
      }
      _isEditMode = !_isEditMode;
    });
  }

  Future<void> _saveProfile() async {
    _tempProfile.firstName = _firstNameController.text;
    _tempProfile.lastName = _lastNameController.text;
    _tempProfile.email = _emailController.text;
    _tempProfile.phoneNumber = _phoneController.text;
    _tempProfile.address = _addressController.text;
    _tempProfile.city = _cityController.text;
    _tempProfile.state = _stateController.text;
    _tempProfile.zipCode = _zipController.text;
    _tempProfile.occupation = _occupationController.text;
    _tempProfile.companyName = _companyController.text;
    _tempProfile.income = double.parse(_incomeController.text);
    _tempProfile.expectedSalary = double.parse(_expectedSalaryController.text);
    _tempProfile.yearsOfExperience = int.parse(
      _yearsOfExperienceController.text,
    );

    // Update dates
    _tempProfile.dateOfBirth = _selectedDate;
    _tempProfile.availabilityDate = _availabilityDate;

    // Update selection values
    _tempProfile.gender = _selectedGender;
    _tempProfile.employmentType = _selectedEmploymentType;
    _tempProfile.preferredContactMethod = _selectedContactMethod;
    _tempProfile.languages = _selectedLanguages;
    _tempProfile.certifications = _selectedCertifications;
    _tempProfile.availabilityWeekdays = _weekdayHours;

    final success = await widget.presenter.saveUserProfile(_tempProfile);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: ValueListenableBuilder<bool>(
        valueListenable: widget.presenter.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ValueListenableBuilder<UserProfile?>(
            valueListenable: widget.presenter.userProfile,
            builder: (context, profile, _) {
              if (profile == null) {
                return const Center(child: Text('No profile data available'));
              }

              return ValueListenableBuilder<String?>(
                valueListenable: widget.presenter.errorMessage,
                builder: (context, errorMessage, _) {
                  if (errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: widget.presenter.loadUserProfile,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  return _isEditMode
                      ? _buildEditProfileForm(profile)
                      : _buildProfileView(profile);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProfileView(UserProfile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Edit Button at the top
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('EDIT PROFILE'),
              onPressed: _toggleEditMode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Main content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Basic profile information
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViewHeaderSection(profile: profile),
                    ViewPersonalInfoSection(
                      profile: profile,
                      presenter: widget.presenter,
                    ),
                    ViewAddressSection(profile: profile),
                    ViewProfessionalInfoSection(profile: profile),
                    ViewInterestsSection(profile: profile),
                    ViewLanguagesSection(profile: profile),
                    ViewCertificationsSection(profile: profile),
                    ViewPreferencesSection(
                      profile: profile,
                      presenter: widget.presenter,
                    ),
                    ViewAvailabilitySection(profile: profile),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Right side - Detailed information in a card
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ViewSkillsSection(profile: profile),
                        const Divider(height: 32),
                        ViewWorkHistorySection(profile: profile),
                        const Divider(height: 32),
                        ViewEducationSection(profile: profile),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileForm(UserProfile profile) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image
            EditHeaderSection(
              profile: _tempProfile,
              onImagePick: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image upload not implemented in this demo'),
                  ),
                );
              },
            ),
            const Divider(),
            const SizedBox(height: 16),

            // Personal Information Section
            EditPersonalInfoSection(profile: _tempProfile, formKey: _formKey),
            const SizedBox(height: 24),

            // Address Section
            EditAddressSection(profile: _tempProfile, formKey: _formKey),
            const SizedBox(height: 24),

            // Professional Information Section
            EditProfessionalInfoSection(
              profile: _tempProfile,
              formKey: _formKey,
            ),
            const SizedBox(height: 24),

            // Interests Section
            EditInterestsSection(profile: _tempProfile),
            const SizedBox(height: 24),

            // Additional Information Section (Gender, Employment, Contact, etc.)
            EditAdditionalInfoSection(profile: _tempProfile),
            const SizedBox(height: 24),

            // Languages Section
            EditLanguagesSection(profile: _tempProfile),
            const SizedBox(height: 24),

            // Certifications Section
            EditCertificationsSection(profile: _tempProfile),
            const SizedBox(height: 24),

            // Availability Section (Weekly Hours)
            EditAvailabilitySection(profile: _tempProfile),
            const SizedBox(height: 24),

            // Preferences Section (App Settings)
            EditPreferencesSection(profile: _tempProfile),
            const SizedBox(height: 32),

            // Save and Cancel buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveProfile();
                        _toggleEditMode();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('SAVE PROFILE'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _toggleEditMode,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text('CANCEL'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
