import 'package:equatable/equatable.dart';

class Training extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Training({
    required this.id,
    required this.title,
    this.description = "",
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, title, description, date, createdAt, updatedAt];
}
