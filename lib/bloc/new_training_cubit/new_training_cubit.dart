import 'package:bloc/bloc.dart';

part 'new_training_state.dart';

class NewTrainingCubit extends Cubit<NewTrainingState> {
  NewTrainingCubit() : super(NewTrainingMode());

  void changeMode(NewTrainingState mode) {
    emit(mode);
  }
}
