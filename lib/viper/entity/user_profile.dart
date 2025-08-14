import 'work_experience.dart';
import 'education.dart';

class UserProfile {
  final String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;
  String city;
  String state;
  String zipCode;
  DateTime dateOfBirth;
  String occupation;
  String companyName;
  double income;
  List<String> interests;
  bool isSubscribed;
  String profileImageUrl;
  Map<String, bool> preferences;

  // Additional data for grid display
  List<WorkExperience> workExperience;
  List<Education> education;
  Map<String, int> skillRatings;

  // Additional fields for new form widgets
  String gender;
  List<String> languages;
  String employmentType;
  DateTime availabilityDate;
  double expectedSalary;
  int yearsOfExperience;
  List<String> certifications;
  String preferredContactMethod;
  bool isRemoteWorkEligible;
  bool isWillingToRelocate;
  Map<String, int> availabilityWeekdays; // Hours per weekday (0-24)

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.dateOfBirth,
    required this.occupation,
    required this.companyName,
    required this.income,
    required this.interests,
    required this.isSubscribed,
    required this.profileImageUrl,
    required this.preferences,
    required this.workExperience,
    required this.education,
    required this.skillRatings,
    required this.gender,
    required this.languages,
    required this.employmentType,
    required this.availabilityDate,
    required this.expectedSalary,
    required this.yearsOfExperience,
    required this.certifications,
    required this.preferredContactMethod,
    required this.isRemoteWorkEligible,
    required this.isWillingToRelocate,
    required this.availabilityWeekdays,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      occupation: json['occupation'],
      companyName: json['companyName'],
      income: json['income'],
      interests: List<String>.from(json['interests']),
      isSubscribed: json['isSubscribed'],
      profileImageUrl: json['profileImageUrl'],
      preferences: Map<String, bool>.from(json['preferences']),
      workExperience: (json['workExperience'] as List)
          .map((e) => WorkExperience.fromJson(e))
          .toList(),
      education: (json['education'] as List)
          .map((e) => Education.fromJson(e))
          .toList(),
      skillRatings: Map<String, int>.from(json['skillRatings']),
      gender: json['gender'] ?? '',
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : <String>[],
      employmentType: json['employmentType'] ?? '',
      availabilityDate: json['availabilityDate'] != null
          ? DateTime.parse(json['availabilityDate'])
          : DateTime.now(),
      expectedSalary: json['expectedSalary'] ?? 0.0,
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      certifications: json['certifications'] != null
          ? List<String>.from(json['certifications'])
          : <String>[],
      preferredContactMethod: json['preferredContactMethod'] ?? 'email',
      isRemoteWorkEligible: json['isRemoteWorkEligible'] ?? false,
      isWillingToRelocate: json['isWillingToRelocate'] ?? false,
      availabilityWeekdays: json['availabilityWeekdays'] != null
          ? Map<String, int>.from(json['availabilityWeekdays'])
          : <String, int>{
              'Monday': 8,
              'Tuesday': 8,
              'Wednesday': 8,
              'Thursday': 8,
              'Friday': 8,
              'Saturday': 0,
              'Sunday': 0,
            },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'occupation': occupation,
      'companyName': companyName,
      'income': income,
      'interests': interests,
      'isSubscribed': isSubscribed,
      'profileImageUrl': profileImageUrl,
      'preferences': preferences,
      'workExperience': workExperience.map((e) => e.toJson()).toList(),
      'education': education.map((e) => e.toJson()).toList(),
      'skillRatings': skillRatings,
      'gender': gender,
      'languages': languages,
      'employmentType': employmentType,
      'availabilityDate': availabilityDate.toIso8601String(),
      'expectedSalary': expectedSalary,
      'yearsOfExperience': yearsOfExperience,
      'certifications': certifications,
      'preferredContactMethod': preferredContactMethod,
      'isRemoteWorkEligible': isRemoteWorkEligible,
      'isWillingToRelocate': isWillingToRelocate,
      'availabilityWeekdays': availabilityWeekdays,
    };
  }
}
