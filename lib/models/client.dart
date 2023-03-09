import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// enum TrainingDays {
//   monday,
//   tuesday,
//   wednesday,
//   thursday,
//   friday,
//   saturday,
//   sunday,
// }

class Client extends Equatable {
  final int id;
  final String name;
  final String phone;
  final DateTime birthday;
  final String clientGoal;
  final String clientNote;
  final bool isArchive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double weight;
  final Map<String, TimeOfDay?> trainingDays;
  final int paidTrainings;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.birthday,
    this.isArchive = false,
    this.clientGoal = "",
    this.clientNote = "",
    DateTime? creationDate,
    DateTime? updateDate,
    required this.weight,
    Map<String, TimeOfDay?>?trainingDays,
    this.paidTrainings = 0,
  })  : createdAt = creationDate ?? DateTime.now(),
        updatedAt = updateDate ?? DateTime.now(),
        trainingDays = trainingDays ?? <String, TimeOfDay?>{
          'monday': null,
          'tuesday': null,
          'wednesday': null,
          'thursday': null,
          'friday': null,
          'saturday': null,
          'sunday': null,
        };

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        birthday,
        clientGoal,
        clientNote,
        isArchive,
        createdAt,
        updatedAt,
        weight,
        trainingDays,
        paidTrainings,
      ];

  Client copyWith({
    int? id,
    String? name,
    String? phone,
    DateTime? birthday,
    String? clientGoal,
    String? clientNote,
    bool? isArchive,
    DateTime? creationDate,
    DateTime? updateDate,
    double? weight,
    Map<String, TimeOfDay?>? trainingDays,
    int? paidTrainings,
  }) {
    DateTime createdAt = creationDate ?? DateTime.now();
    DateTime updatedAt = updateDate ?? DateTime.now();
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      clientGoal: clientGoal ?? this.clientGoal,
      clientNote: clientNote ?? this.clientNote,
      isArchive: isArchive ?? this.isArchive,
      creationDate: createdAt ?? this.createdAt,
      updateDate: updatedAt ?? this.updatedAt,
      weight: weight ?? this.weight,
      trainingDays: trainingDays ?? this.trainingDays,
      paidTrainings: paidTrainings ?? this.paidTrainings,
    );
  }
}
