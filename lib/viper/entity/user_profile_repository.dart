import '../entity/user_profile.dart';
import '../entity/work_experience.dart';
import '../entity/education.dart';

class UserProfileRepository {
  // Singleton instance
  static final UserProfileRepository _instance =
      UserProfileRepository._internal();
  factory UserProfileRepository() => _instance;
  UserProfileRepository._internal();

  Future<UserProfile> getUserProfile() async {
    // Simulating network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock user profile data
    return UserProfile(
      id: '123456',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1 (555) 123-4567',
      address: '123 Main Street',
      city: 'New York',
      state: 'NY',
      zipCode: '10001',
      dateOfBirth: DateTime(1985, 5, 15),
      occupation: 'Software Engineer',
      companyName: 'Tech Solutions Inc.',
      income: 120000.0,
      interests: ['Programming', 'Reading', 'Hiking', 'Photography'],
      isSubscribed: true,
      profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      preferences: {
        'darkMode': true,
        'notifications': true,
        'newsletter': false,
        'dataSharing': false,
      },
      workExperience: [
        WorkExperience(
          companyName: 'Tech Solutions Inc.',
          position: 'Senior Software Engineer',
          startDate: DateTime(2018, 3, 15),
          endDate: null, // Current job
          description: 'Leading development team on multiple projects',
          achievements: [
            'Reduced app loading time by 40%',
            'Implemented CI/CD pipeline',
            'Mentored 5 junior developers'
          ],
        ),
        WorkExperience(
          companyName: 'Digital Innovations LLC',
          position: 'Software Developer',
          startDate: DateTime(2015, 7, 1),
          endDate: DateTime(2018, 2, 28),
          description: 'Full-stack developer for web applications',
          achievements: [
            'Developed e-commerce platform with 100K+ users',
            'Optimized database queries resulting in 30% faster response times',
            'Implemented secure payment processing system'
          ],
        ),
        WorkExperience(
          companyName: 'StartUp Tech',
          position: 'Junior Developer',
          startDate: DateTime(2013, 6, 15),
          endDate: DateTime(2015, 6, 30),
          description: 'Front-end development for web applications',
          achievements: [
            'Designed responsive UI for mobile and desktop',
            'Contributed to open source libraries',
            'Built analytics dashboard used by entire company'
          ],
        ),
      ],
      education: [
        Education(
          institution: 'MIT',
          degree: 'Master of Science',
          field: 'Computer Science',
          startDate: DateTime(2011, 9, 1),
          endDate: DateTime(2013, 5, 15),
          gpa: 3.8,
          achievements: [
            'Graduated with honors',
            'Research assistant in AI lab',
            'Published paper on machine learning algorithms'
          ],
        ),
        Education(
          institution: 'University of California',
          degree: 'Bachelor of Science',
          field: 'Software Engineering',
          startDate: DateTime(2007, 9, 1),
          endDate: DateTime(2011, 5, 30),
          gpa: 3.6,
          achievements: [
            'Dean\'s list for 6 semesters',
            'Led programming club',
            'Developed award-winning student project'
          ],
        ),
      ],
      skillRatings: {
        'Flutter': 95,
        'Dart': 90,
        'JavaScript': 85,
        'Python': 80,
        'Java': 75,
        'SQL': 85,
        'React': 70,
        'AWS': 65,
        'Docker': 75,
        'Git': 90,
      },
    );
  }

  Future<bool> updateUserProfile(UserProfile profile) async {
    // Simulating network delay and success response
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
