import 'package:bloc/bloc.dart';
part 'training_page_event.dart';

enum TemplateOrExercise { template, exercise }

class TrainingPageBloc extends Bloc<TrainingPageEvent, TemplateOrExercise> {
  TrainingPageBloc() : super(TemplateOrExercise.template) {
    on<TrainingPageModeChanged>(_trainingPageModeChanged);
  }

  void _trainingPageModeChanged(
      TrainingPageModeChanged event, Emitter<TemplateOrExercise> emit) async {

    if (event.value != state) {
      emit(event.value);
    }
  }
}
