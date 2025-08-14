class Education {
  final String institution;
  final String degree;
  final String field;
  final DateTime startDate;
  final DateTime? endDate;
  final double gpa;
  final List<String> achievements;

  Education({
    required this.institution,
    required this.degree,
    required this.field,
    required this.startDate,
    this.endDate,
    required this.gpa,
    required this.achievements,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'],
      degree: json['degree'],
      field: json['field'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      gpa: json['gpa'],
      achievements: List<String>.from(json['achievements']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'degree': degree,
      'field': field,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'gpa': gpa,
      'achievements': achievements,
    };
  }
}
