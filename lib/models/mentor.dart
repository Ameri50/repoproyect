// lib/models/mentor.dart
class Mentor {
  final String name;
  final String specialty;
  final String specialtyEn;
  final double rating;
  final List<String> expertise;
  final List<String> expertiseEn;
  final String description;
  final String descriptionEn;
  final String image;
  final String category;

  Mentor({
    required this.name,
    required this.specialty,
    required this.specialtyEn,
    required this.rating,
    required this.expertise,
    required this.expertiseEn,
    required this.description,
    required this.descriptionEn,
    required this.image,
    required this.category,
  });
}