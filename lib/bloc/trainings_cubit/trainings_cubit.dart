import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainings/models/training.dart';

part 'trainings_state.dart';

List<Training> _trainings = [
  Training(
    id: 0,
    title: 'Template Name',
    description: 'Description here',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Training(
    id: 1,
    title: 'Template Name',
    description: 'Description here',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Training(
    id: 2,
    title: 'Template Name',
    description: 'Description here',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

class TrainingsCubit extends Cubit<TrainingsState> {
  TrainingsCubit()
      : super(const TrainingsState(status: TrainingsStatus.initial));

  void fetchTrainings() {
    emit(
      TrainingsState(
        status: TrainingsStatus.success,
        trainings: _trainings,
      ),
    );
  }
}
