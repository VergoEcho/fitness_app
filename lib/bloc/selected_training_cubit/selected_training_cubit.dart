import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/models/training.dart';

part 'selected_training_state.dart';

Training tempTraining = Training(
  id: 1,
  title: 'Training name',
  description: 'Training notes ',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

class SelectedTrainingCubit extends Cubit<SelectedTrainingState> {
  SelectedTrainingCubit() : super(const SelectedTrainingNone());

  void select({required DateTime selectedDay, required Client client}) {
    // TODO: implement training search with selectedDay by client.id
    emit(SelectedTrainingSelected(training: tempTraining));
  }
  void clear() {
    emit(const SelectedTrainingNone());
  }
}
