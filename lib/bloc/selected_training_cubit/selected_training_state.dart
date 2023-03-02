part of 'selected_training_cubit.dart';

class SelectedTrainingState extends Equatable {

  final Training? training;

  const SelectedTrainingState({this.training});

  @override
  List<Object?> get props => throw [training];

}

class SelectedTrainingNone extends SelectedTrainingState {
  const SelectedTrainingNone();
}

class SelectedTrainingSelected extends SelectedTrainingState {
  const SelectedTrainingSelected({super.training});
}
