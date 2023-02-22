part of 'training_page_bloc.dart';

abstract class TrainingPageEvent {
  const TrainingPageEvent();
}

class TrainingPageModeChanged extends TrainingPageEvent {
  const TrainingPageModeChanged(this.value);
  final TemplateOrExercise value;
}