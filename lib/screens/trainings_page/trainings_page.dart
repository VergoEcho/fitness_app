import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/exercise_edit_cubit/exercise_edit_cubit.dart';
import 'package:trainings/bloc/exercises_cubit/exercises_cubit.dart';
import 'package:trainings/bloc/new_training_cubit/new_training_cubit.dart';
import 'package:trainings/bloc/search_cubit/search_cubit.dart';
import 'package:trainings/bloc/trainings_cubit/trainings_cubit.dart';
import 'package:trainings/bloc/trainings_page_bloc/training_page_bloc.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/training.dart';
import 'package:trainings/common_widgets/filled_button.dart';
import 'package:trainings/screens/exercise_page/exercise_page.dart';
import 'package:trainings/screens/new_training_page/new_training_page.dart';
import 'package:trainings/screens/trainings_page/widgets/exercise_card.dart';
import 'package:trainings/screens/trainings_page/widgets/training_template_card.dart';
import 'package:trainings/screens/trainings_search.dart';

import '../../models/exercise.dart';

class TrainingsPage extends StatelessWidget {
  const TrainingsPage({Key? key}) : super(key: key);

  static const String route = '/trainings';

  _createNewTemplate(BuildContext context) {
    context.read<NewTrainingCubit>().changeMode(NewTemplateMode());
    Navigator.of(context, rootNavigator: true).pushNamed(NewTrainingPage.route);
  }

  _openSearch(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(TrainingsSearchPage.route)
        .then(
          (value) => context.read<SearchCubit>().clear(),
        );
  }

  _changePageMode(BuildContext context, TemplateOrExercise value) {
    context.read<TrainingPageBloc>().add(TrainingPageModeChanged(value));
  }

  List selectedList(BuildContext context) {
    TemplateOrExercise state = context.read<TrainingPageBloc>().state;
    if (state == TemplateOrExercise.template) {
      return context.read<TrainingsCubit>().state.trainings;
    }
    return context.read<ExercisesCubit>().state.exercises;
  }

  Widget? _tileBuilder(BuildContext context, int index) {
    TemplateOrExercise state = context.read<TrainingPageBloc>().state;

    if (state == TemplateOrExercise.template) {
      Training item = selectedList(context)[index];
      return Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: TrainingTemplateCard(
          template: item,
        ),
      );
    }
    Exercise item = selectedList(context)[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ExerciseCard(
        exercise: item,
        onTap: () {
          context.read<ExerciseEditCubit>().changeMode(ExerciseEditMode());
          Navigator.of(context, rootNavigator: true)
              .pushNamed(ExercisePage.route);
        },
      ),
    );
  }

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
                        onPressed: () => _createNewTemplate(context),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Hero(
                    tag: 'trainings_search',
                    child: CupertinoSearchTextField(
                      style: TextStyle(
                        color: FitnessColors.darkGray,
                      ),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: FitnessColors.darkGray,
                      ),
                      suffixIcon: Icon(
                        CupertinoIcons.mic_solid,
                        color: FitnessColors.blindGray,
                      ),
                      suffixMode: OverlayVisibilityMode.always,
                      onTap: () => _openSearch(context),
                      onSuffixTap: () {},
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
                          onValueChanged: (value) =>
                              _changePageMode(context, value!),
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
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedList(context).length,
                    itemBuilder: _tileBuilder,
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
