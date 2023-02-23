import 'package:equatable/equatable.dart';

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
  final String birthday;
  final String clientGoal;
  final String clientNote;
  final bool isArchive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double weight;
  final List<String> trainingDays;

  const Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.birthday,
    this.isArchive = false,
    this.clientGoal = "",
    this.clientNote = "",
    required this.createdAt,
    required this.updatedAt,
    required this.weight,
    this.trainingDays = const [],
  });

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
      ];
}
