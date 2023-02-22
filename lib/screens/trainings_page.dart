import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/trainings_page_bloc/training_page_bloc.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/training.dart';
import 'package:trainings/ui/filled_button.dart';
import 'package:trainings/widgets/exercise_card.dart';
import 'package:trainings/widgets/training_template_card.dart';

import '../models/exercise.dart';

List<Training> _templates = [
  Training(
    id: 0,
    title: 'Leg day',
    description: 'Training focused on legs',
    date: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Training(
    id: 1,
    title: 'Arms day',
    description: 'Training focused on arms',
    date: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Training(
    id: 2,
    title: 'Core day',
    description: 'Training focused on core',
    date: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

List<Exercise> _exercises = [
  Exercise(
    id: 2,
    title: 'Leg stretches',
    description: '20 kg x 20 Reps',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [],
  ),
];

class TrainingsPage extends StatelessWidget {
  const TrainingsPage({Key? key}) : super(key: key);

  static const String route = '/trainings';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: FitnessColors.whiteGray,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
              decoration: BoxDecoration(
                color: FitnessColors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.trainings_page_title.tr(),
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppleFilledButton(
                        text: LocaleKeys.trainings_page_new_template
                            .tr()
                            .toUpperCase(),
                        onPressed: () {},
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  const CupertinoSearchTextField(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<TrainingPageBloc, TemplateOrExercise>(
                      builder: (context, state) {
                        return CupertinoSlidingSegmentedControl<
                            TemplateOrExercise>(
                          groupValue: state,
                          children: <TemplateOrExercise, Widget>{
                            TemplateOrExercise.template:
                            Text(LocaleKeys.trainings_page_templates.tr()),
                            TemplateOrExercise.exercise:
                            Text(LocaleKeys.trainings_page_exercises.tr()),
                          },
                          onValueChanged: (value) {
                            context.read<TrainingPageBloc>().add(
                                TrainingPageModeChanged(value!));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<TrainingPageBloc, TemplateOrExercise>(
                builder: (context, state) {
                  List selectedList() {
                    if (state == TemplateOrExercise.template) {
                      return _templates;
                    }
                    return _exercises;
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedList().length,
                    itemBuilder: (context, index) {
                      if (state == TemplateOrExercise.template) {
                        Training item = selectedList()[index];
                        return TrainingTemplateCard(
                          template: item,
                        );
                      }
                      Exercise item = selectedList()[index];
                      return ExerciseCard(exercise: item);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
