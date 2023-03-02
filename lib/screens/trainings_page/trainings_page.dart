import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/exercises_cubit/exercises_cubit.dart';
import 'package:trainings/bloc/trainings_page_bloc/training_page_bloc.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/training.dart';
import 'package:trainings/common_widgets/filled_button.dart';
import 'package:trainings/screens/exercise_page/exercise_page.dart';
import 'package:trainings/screens/new_template_page/new_template_page.dart';
import 'package:trainings/screens/trainings_page/widgets/exercise_card.dart';
import 'package:trainings/screens/trainings_page/widgets/training_template_card.dart';

import '../../models/exercise.dart';

List<Training> _templates = [
  Training(
    id: 0,
    title: 'Template Name',
    description: 'Description here',
    date: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Training(
    id: 1,
    title: 'Template Name',
    description: 'Description here',
    date: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Training(
    id: 2,
    title: 'Template Name',
    description: 'Description here',
    date: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
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
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(NewTemplatePage.route);
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  CupertinoSearchTextField(
                    style: TextStyle(
                      color: FitnessColors.darkGray,
                    ),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: FitnessColors.darkGray,
                    ),
                    suffixIcon: Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: FitnessColors.darkGray,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<TrainingPageBloc, TemplateOrExercise>(
                      builder: (context, state) {
                        return CupertinoSlidingSegmentedControl<
                            TemplateOrExercise>(
                          thumbColor: FitnessColors.white,
                          groupValue: state,
                          children: <TemplateOrExercise, Widget>{
                            TemplateOrExercise.template:
                                Text(LocaleKeys.trainings_page_templates.tr()),
                            TemplateOrExercise.exercise:
                                Text(LocaleKeys.trainings_page_exercises.tr()),
                          },
                          onValueChanged: (value) {
                            context
                                .read<TrainingPageBloc>()
                                .add(TrainingPageModeChanged(value!));
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
                    return context.read<ExercisesCubit>().state.exercises;
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
                      return ExerciseCard(
                        exercise: item,
                        onTap: () => Navigator.of(context, rootNavigator: true)
                            .pushNamed(ExercisePage.route),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
