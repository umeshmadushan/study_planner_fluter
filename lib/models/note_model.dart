import 'dart:io';

class NoteModel {
  final String id;
  final String title;
  final String description;
  final String section;
  final String refference;
  final File? imageData;
  final String? imageUrl;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.section,
    required this.refference,
    this.imageData,
    this.imageUrl,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      section: json['section'] ?? '',
      refference: json['refferebce'] ?? '',
      imageData: json['imageData'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title':title,
      'description':description,
      'section':section,
      'refference':refference,
      'imageData':imageData,
      'imageUrl':imageUrl,
    };
  }
}
