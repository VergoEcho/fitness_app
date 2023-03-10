import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/exercise_edit_cubit/exercise_edit_cubit.dart';
import 'package:trainings/bloc/exercises_cubit/exercises_cubit.dart';
import 'package:trainings/bloc/search_cubit/search_cubit.dart';
import 'package:trainings/bloc/trainings_cubit/trainings_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/models/training.dart';
import 'package:trainings/screens/exercise_page/exercise_page.dart';
import 'package:trainings/screens/trainings_page/widgets/exercise_card.dart';

import 'trainings_page/widgets/training_template_card.dart';

class TrainingsSearchPage extends StatelessWidget {
  static const String route = 'trainings/search';

  const TrainingsSearchPage({Key? key}) : super(key: key);

  List<Training> trainingsList(BuildContext context) {
    String search = context.read<SearchCubit>().state;
    List<Training> trainings = context.read<TrainingsCubit>().state.trainings;
    return trainings.where((training) {
      return training.title.toLowerCase().contains(search.toLowerCase());
    }).toList();
  }

  List<Exercise> exercisesList(BuildContext context) {
    String search = context.read<SearchCubit>().state;
    List<Exercise> exercises = context.read<ExercisesCubit>().state.exercises;
    return exercises.where((exercise) {
      return exercise.title.toLowerCase().contains(search.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: FitnessColors.whiteGray,
      navigationBar: CupertinoNavigationBar(
        border: Border.all(width: 0, color: FitnessColors.white),
        transitionBetweenRoutes: false,
        automaticallyImplyLeading: false,
        backgroundColor: FitnessColors.white,
        middle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Hero(
                  tag: 'trainings_search',
                  child: CupertinoSearchTextField(
                    autofocus: true,
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
                    onChanged: (value) {
                      context.read<SearchCubit>().update(value);
                    },
                    onSuffixTap: () {},
                  ),
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  LocaleKeys.trainings_page_search_cancel.tr(),
                  style: const TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              color: FitnessColors.white,
            ),
            child: const SizedBox(
              height: 28,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, String>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    children: [
                      trainingsList(context).isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(
                                left: 28,
                                top: 16,
                              ),
                              child: Text(
                                LocaleKeys.trainings_page_search_templates
                                    .tr()
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: FitnessColors.blindGray,
                                ),
                              ),
                            ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: trainingsList(context).length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Training item = trainingsList(context)[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 16),
                            child: TrainingTemplateCard(
                              template: item,
                            ),
                          );
                        },
                      ),
                      exercisesList(context).isEmpty
                          ? const SizedBox()
                          : Padding(
                        padding: const EdgeInsets.only(
                          left: 28,
                          top: 16,
                        ),
                        child: Text(
                          LocaleKeys.trainings_page_search_exercises
                              .tr()
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            color: FitnessColors.blindGray,
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: exercisesList(context).length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Exercise exercise = exercisesList(context)[index];
                          return ExerciseCard(
                            exercise: exercise,
                            onTap: () {
                              context
                                  .read<ExerciseEditCubit>()
                                  .changeMode(ExerciseEditMode());
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(ExercisePage.route);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
