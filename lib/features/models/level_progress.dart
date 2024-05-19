import 'dart:convert';

import 'package:ez_english/features/models/section_progress.dart';

class LevelProgress {
  String name;
  String description;
  List<String> completedSections;
  List<SectionProgress> sectionProgress;

  LevelProgress({
    required this.name,
    required this.description,
    required this.completedSections,
    required this.sectionProgress,
  });

  factory LevelProgress.fromMap(Map<String, dynamic> map) {
    return LevelProgress(
      name: map['name'],
      description: map['description'],
      completedSections: List<String>.from(map['completedSections']),
      sectionProgress: (map['sectionProgress'] as List)
          .map((item) => SectionProgress.fromMap(item))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'completedSections': completedSections,
      'sectionProgress': sectionProgress.map((sp) => sp.toMap()).toList(),
    };
  }

  factory LevelProgress.fromJson(String data) {
    return LevelProgress.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}