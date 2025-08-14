class WorkExperience {
  final String companyName;
  final String position;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final List<String> achievements;

  WorkExperience({
    required this.companyName,
    required this.position,
    required this.startDate,
    this.endDate,
    required this.description,
    required this.achievements,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      companyName: json['companyName'],
      position: json['position'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      description: json['description'],
      achievements: List<String>.from(json['achievements']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'position': position,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'description': description,
      'achievements': achievements,
    };
  }
}
