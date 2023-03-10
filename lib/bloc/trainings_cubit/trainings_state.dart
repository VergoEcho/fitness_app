part of 'trainings_cubit.dart';

enum TrainingsStatus { initial, success, failure }

class TrainingsState extends Equatable {
  final List<Training> trainings;
  final TrainingsStatus status;

  const TrainingsState({
    this.trainings = const <Training>[],
    required this.status,
  });


  @override
  List<Object?> get props => [trainings, status];
}