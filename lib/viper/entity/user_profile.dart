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
    };
  }
}
