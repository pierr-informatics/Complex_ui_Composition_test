import 'package:flutter/material.dart';
import '../entity/user_profile.dart';
import '../presenter/user_profile_presenter.dart';
import 'package:intl/intl.dart';
import 'widgets/profile_widgets.dart';

class UserProfileView extends StatefulWidget {
  final UserProfilePresenter presenter;

  const UserProfileView({super.key, required this.presenter});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late UserProfile _tempProfile;
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('yyyy-MM-dd');
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectAvailabilityDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _availabilityDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _availabilityDate) {
      setState(() {
        _availabilityDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          ValueListenableBuilder<UserProfile?>(
            valueListenable: widget.presenter.userProfile,
            builder: (context, profile, _) {
              if (profile != null) {
                return IconButton(
                  icon: Icon(_isEditMode ? Icons.save : Icons.edit),
                  onPressed: _toggleEditMode,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Basic profile information
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
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
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                // Personal Information Section
                _buildSectionTitle('Personal Information'),
                _buildInfoItem('Email', profile.email),
                _buildInfoItem('Phone', profile.phoneNumber),
                _buildInfoItem(
                  'Date of Birth',
                  _dateFormat.format(profile.dateOfBirth),
                ),
                _buildInfoItem('Age', widget.presenter.getAge().toString()),
                _buildInfoItem('Gender', profile.gender.isEmpty ? 'Not specified' : profile.gender),
                _buildInfoItem('Preferred Contact', profile.preferredContactMethod.isEmpty ? 'Not specified' : profile.preferredContactMethod),

                const SizedBox(height: 24),
                // Address Section
                _buildSectionTitle('Address'),
                _buildInfoItem('Street', profile.address),
                _buildInfoItem('City', profile.city),
                _buildInfoItem('State', profile.state),
                _buildInfoItem('ZIP Code', profile.zipCode),

                const SizedBox(height: 24),
                // Professional Information
                _buildSectionTitle('Professional Information'),
                _buildInfoItem('Occupation', profile.occupation),
                _buildInfoItem('Company', profile.companyName),
                _buildInfoItem(
                  'Annual Income',
                  '\$${NumberFormat('#,##0.00').format(profile.income)}',
                ),
                _buildInfoItem('Employment Type', profile.employmentType.isEmpty ? 'Not specified' : profile.employmentType),
                _buildInfoItem('Years of Experience', profile.yearsOfExperience.toString()),
                _buildInfoItem(
                  'Expected Salary',
                  '\$${NumberFormat('#,##0.00').format(profile.expectedSalary)}',
                ),
                _buildInfoItem(
                  'Available From',
                  _dateFormat.format(profile.availabilityDate),
                ),
                _buildInfoItem(
                  'Remote Work Eligible',
                  profile.isRemoteWorkEligible ? 'Yes' : 'No',
                ),
                _buildInfoItem(
                  'Willing to Relocate',
                  profile.isWillingToRelocate ? 'Yes' : 'No',
                ),

                const SizedBox(height: 24),
                // Interests
                _buildSectionTitle('Interests'),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: profile.interests
                      .map((interest) => Chip(label: Text(interest)))
                      .toList(),
                ),

                const SizedBox(height: 24),
                
                // Languages
                _buildSectionTitle('Languages'),
                profile.languages.isEmpty 
                  ? const Text('No languages specified')
                  : Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: profile.languages
                          .map((lang) => Chip(
                            label: Text(lang),
                            backgroundColor: Colors.blue.shade100,
                          ))
                          .toList(),
                    ),
                
                const SizedBox(height: 24),
                
                // Certifications
                _buildSectionTitle('Certifications'),
                profile.certifications.isEmpty 
                  ? const Text('No certifications added')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: profile.certifications
                          .map((cert) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.verified, color: Colors.green),
                                const SizedBox(width: 8),
                                Text(cert, style: const TextStyle(fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ))
                          .toList(),
                    ),
                
                const SizedBox(height: 24),
                // Preferences
                _buildSectionTitle('Preferences'),
                ...profile.preferences.entries.map(
                  (entry) => SwitchListTile(
                    title: Text(_formatPreferenceKey(entry.key)),
                    value: entry.value,
                    onChanged: (bool value) {
                      widget.presenter.updatePreference(entry.key, value);
                    },
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Availability Hours
                _buildSectionTitle('Weekly Availability'),
                ...profile.availabilityWeekdays.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w500)),
                        Text('${entry.value} hours', 
                          style: TextStyle(
                            color: entry.value > 0 ? Colors.green : Colors.grey,
                            fontWeight: entry.value > 0 ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right side - Complex grid with additional information
          const SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Skills section with bar visualization
                    _buildSectionTitle('Skills'),
                    ...profile.skillRatings.entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('${entry.value}%'),
                              ],
                            ),
                            const SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: entry.value / 100,
                              minHeight: 8,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getColorForSkillLevel(entry.value),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Divider(height: 32),

                    // Work experience section
                    _buildSectionTitle('Work Experience'),
                    ...profile.workExperience.map(
                      (exp) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exp.position,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              exp.companyName,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              _formatWorkPeriod(exp.startDate, exp.endDate),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 8),
                            Text(exp.description),
                            const SizedBox(height: 4),
                            if (exp.achievements.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              const Text(
                                'Key Achievements:',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 4),
                              ...exp.achievements.map(
                                (achievement) => Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    top: 2.0,
                                    bottom: 2.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('• '),
                                      Expanded(child: Text(achievement)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            if (profile.workExperience.last != exp)
                              const Divider(),
                          ],
                        ),
                      ),
                    ),

                    const Divider(height: 32),

                    // Education section
                    _buildSectionTitle('Education'),
                    ...profile.education.map(
                      (edu) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              edu.institution,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${edu.degree} in ${edu.field}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              _formatWorkPeriod(edu.startDate, edu.endDate),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 4),
                            Text('GPA: ${edu.gpa.toStringAsFixed(1)}'),
                            if (edu.achievements.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              const Text(
                                'Achievements:',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 4),
                              ...edu.achievements.map(
                                (achievement) => Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    top: 2.0,
                                    bottom: 2.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('• '),
                                      Expanded(child: Text(achievement)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            if (profile.education.last != edu) const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () {
                          // In a real app, this would open image picker
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Image upload not implemented in this demo',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Personal Information Section
            _buildSectionTitle('Personal Information'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegExp = RegExp(
                  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                );
                if (!emailRegExp.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (value.length < 10) {
                  return 'Phone number should be at least 10 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(_dateFormat.format(_selectedDate)),
              ),
            ),

            const SizedBox(height: 24),
            // Address Section
            _buildSectionTitle('Address'),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Street Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _stateController,
                    decoration: const InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _zipController,
                    decoration: const InputDecoration(
                      labelText: 'ZIP Code',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      if (value.length != 5 || int.tryParse(value) == null) {
                        return 'Invalid ZIP';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            // Professional Information
            _buildSectionTitle('Professional Information'),
            TextFormField(
              controller: _occupationController,
              decoration: const InputDecoration(
                labelText: 'Occupation',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.work),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _companyController,
              decoration: const InputDecoration(
                labelText: 'Company',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.business),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _incomeController,
              decoration: const InputDecoration(
                labelText: 'Annual Income',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your income';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),
            // Interests
            _buildSectionTitle('Interests'),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                ...profile.interests.map(
                  (interest) => ProfileWidgets.interestChip(interest, () {
                    setState(() {
                      _tempProfile.interests.remove(interest);
                    });
                  }),
                ),
                ProfileWidgets.addInterestChip(() {
                  _showAddInterestDialog();
                }),
              ],
            ),

            const SizedBox(height: 24),
            // Additional Information Section
            _buildSectionTitle('Additional Information'),

            // Gender Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              value: _selectedGender.isNotEmpty ? _selectedGender : null,
              hint: const Text('Select Gender'),
              isExpanded: true,
              items: ['Male', 'Female', 'Non-binary', 'Prefer not to say'].map((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            // Employment Type Segmented Button
            const Text(
              'Employment Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment<String>(
                  value: 'Full-time',
                  label: Text('Full-time'),
                  icon: Icon(Icons.work),
                ),
                ButtonSegment<String>(
                  value: 'Part-time',
                  label: Text('Part-time'),
                  icon: Icon(Icons.work_outline),
                ),
                ButtonSegment<String>(
                  value: 'Contract',
                  label: Text('Contract'),
                  icon: Icon(Icons.description),
                ),
                ButtonSegment<String>(
                  value: 'Freelance',
                  label: Text('Freelance'),
                  icon: Icon(Icons.person_outline),
                ),
              ],
              selected: {
                _selectedEmploymentType.isNotEmpty
                    ? _selectedEmploymentType
                    : 'Full-time',
              },
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedEmploymentType = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 16),

            // Availability Date Picker
            InkWell(
              onTap: () => _selectAvailabilityDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Availability Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event_available),
                ),
                child: Text(_dateFormat.format(_availabilityDate)),
              ),
            ),
            const SizedBox(height: 16),

            // Expected Salary Slider
            TextFormField(
              controller: _expectedSalaryController,
              decoration: InputDecoration(
                labelText:
                    'Expected Salary (\$${_expectedSalaryController.text})',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.monetization_on),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {}); // Update the label with new value
              },
            ),
            Slider(
              min: 50000,
              max: 200000,
              divisions: 15,
              value:
                  double.tryParse(_expectedSalaryController.text) ??
                  profile.expectedSalary,
              label:
                  '\$${(double.tryParse(_expectedSalaryController.text) ?? profile.expectedSalary).toStringAsFixed(0)}',
              onChanged: (value) {
                setState(() {
                  _expectedSalaryController.text = value.toStringAsFixed(0);
                });
              },
            ),
            const SizedBox(height: 16),

            // Years of Experience Stepper
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _yearsOfExperienceController,
                    decoration: const InputDecoration(
                      labelText: 'Years of Experience',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timeline),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          final currentValue =
                              int.tryParse(_yearsOfExperienceController.text) ??
                              0;
                          _yearsOfExperienceController.text = (currentValue + 1)
                              .toString();
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          final currentValue =
                              int.tryParse(_yearsOfExperienceController.text) ??
                              0;
                          if (currentValue > 0) {
                            _yearsOfExperienceController.text =
                                (currentValue - 1).toString();
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Preferred Contact Method Radio Buttons
            const Text(
              'Preferred Contact Method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Email'),
              value: 'email',
              groupValue: _selectedContactMethod,
              onChanged: (value) {
                setState(() {
                  _selectedContactMethod = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Phone'),
              value: 'phone',
              groupValue: _selectedContactMethod,
              onChanged: (value) {
                setState(() {
                  _selectedContactMethod = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Text Message'),
              value: 'sms',
              groupValue: _selectedContactMethod,
              onChanged: (value) {
                setState(() {
                  _selectedContactMethod = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Remote Work Checkbox
            CheckboxListTile(
              title: const Text('Eligible for Remote Work'),
              subtitle: const Text('Can work fully remote'),
              value: _tempProfile.isRemoteWorkEligible,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _tempProfile.isRemoteWorkEligible = value;
                  });
                }
              },
            ),

            // Relocation Checkbox
            CheckboxListTile(
              title: const Text('Willing to Relocate'),
              subtitle: const Text('Open to moving for the right position'),
              value: _tempProfile.isWillingToRelocate,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _tempProfile.isWillingToRelocate = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            // Languages Chips
            const Text(
              'Languages',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                ...[
                  'English',
                  'Spanish',
                  'French',
                  'German',
                  'Chinese',
                  'Japanese',
                  'Russian',
                ].map((language) {
                  final isSelected = _selectedLanguages.contains(language);
                  return FilterChip(
                    label: Text(language),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedLanguages.add(language);
                        } else {
                          _selectedLanguages.remove(language);
                        }
                      });
                    },
                    selectedColor: Colors.blue.shade100,
                    checkmarkColor: Colors.blue.shade800,
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),

            // Certifications List with Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Certifications',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _showAddCertificationDialog();
                  },
                  tooltip: 'Add Certification',
                ),
              ],
            ),
            ..._selectedCertifications.map(
              (cert) => Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text(cert),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      setState(() {
                        _selectedCertifications.remove(cert);
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Availability Weekday Hours
            const Text(
              'Availability Hours per Day',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._weekdayHours.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    SizedBox(width: 100, child: Text(entry.key)),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 12,
                        divisions: 12,
                        value: entry.value.toDouble(),
                        label: '${entry.value} hours',
                        onChanged: (value) {
                          setState(() {
                            _weekdayHours[entry.key] = value.toInt();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 40, child: Text('${entry.value}h')),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            // Preferences
            _buildSectionTitle('Preferences'),
            ...profile.preferences.entries.map(
              (entry) => SwitchListTile(
                title: Text(_formatPreferenceKey(entry.key)),
                value: entry.value,
                onChanged: (bool value) {
                  setState(() {
                    _tempProfile.preferences[entry.key] = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveProfile();
                    _toggleEditMode();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('SAVE PROFILE'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  _toggleEditMode();
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('CANCEL'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatPreferenceKey(String key) {
    // Convert camelCase to words with first letter capitalized
    final result = key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return result.substring(0, 1).toUpperCase() + result.substring(1);
  }

  // Helper for formatting work date ranges
  String _formatWorkPeriod(DateTime startDate, DateTime? endDate) {
    final start = DateFormat('MMM yyyy').format(startDate);
    final end = endDate != null
        ? DateFormat('MMM yyyy').format(endDate)
        : 'Present';
    return '$start - $end';
  }

  // Helper for determining color based on skill level
  Color _getColorForSkillLevel(int level) {
    if (level >= 90) return Colors.green;
    if (level >= 75) return Colors.blue;
    if (level >= 60) return Colors.orange;
    return Colors.red;
  }

  void _showAddInterestDialog() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Interest'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Enter interest'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              final interest = textController.text.trim();
              if (interest.isNotEmpty) {
                setState(() {
                  _tempProfile.interests.add(interest);
                });
              }
              Navigator.pop(context);
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }

  void _showAddCertificationDialog() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Certification'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Enter certification name',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              final certification = textController.text.trim();
              if (certification.isNotEmpty) {
                setState(() {
                  _selectedCertifications.add(certification);
                });
              }
              Navigator.pop(context);
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }
}
