import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/exercise_edit_cubit/exercise_edit_cubit.dart';
import 'package:trainings/bloc/new_training_cubit/new_training_cubit.dart';
import 'package:trainings/common_widgets/field_tile.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/models/training.dart';
import 'package:trainings/screens/exercise_page/exercise_page.dart';
import 'package:trainings/screens/exercise_search_page/exercises_search_page.dart';
import 'package:trainings/screens/trainings_page/widgets/exercise_card.dart';

import 'widgets/template_card.dart';

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

List<Exercise> _exercises = [
  Exercise(
    id: 0,
    title: 'Exercise Name',
    description: 'Distance (km)/Time (min)',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [],
  ),
  Exercise(
    id: 1,
    title: 'Exercise Name',
    description: 'Distance (km)/Time (min)',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [],
  ),
];

List<Exercise> _selectedExercises = [];

class NewTrainingPage extends StatefulWidget {
  const NewTrainingPage({Key? key}) : super(key: key);

  static const String route = '/trainings/new_training';

  @override
  State<NewTrainingPage> createState() => _NewTrainingPageState();
}

class _NewTrainingPageState extends State<NewTrainingPage> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTrainingCubit, NewTrainingState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          backgroundColor: FitnessColors.whiteGray,
          navigationBar: CupertinoNavigationBar(
            border: Border.all(width: 0, color: FitnessColors.white),
            backgroundColor: FitnessColors.white,
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 4, vertical: 0),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.chevron_back,
                  ),
                  Text(LocaleKeys.back.tr())
                ],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            middle: Text(
              state is NewTrainingMode
                  ? LocaleKeys.new_training_page_title.tr()
                  : LocaleKeys.new_template_page_title.tr(),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: FitnessColors.white,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(24),
                          bottomLeft: Radius.circular(24))),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                  child: Column(
                    children: [
                      FieldTile(
                        formKey: _formKey,
                        validator: (String? text) {
                          if (text == null || text.isEmpty || text == '') {
                            return state is NewTrainingMode
                                ? LocaleKeys.new_training_page_error_name_field
                                    .tr()
                                : LocaleKeys.new_template_page_error_name_field;
                          }
                          return null;
                        },
                        withBorder: true,
                        text: state is NewTrainingMode
                            ? LocaleKeys.new_training_page_name.tr()
                            : LocaleKeys.new_template_page_name.tr(),
                        controller: _name,
                      ),
                      FieldTile(
                        withBorder: true,
                        text: state is NewTrainingMode
                            ? LocaleKeys.new_training_page_description.tr()
                            : LocaleKeys.new_template_page_description.tr(),
                        controller: _description,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListView.builder(
                        itemCount: _selectedExercises.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ExerciseCard(
                              exercise: _selectedExercises[index],
                              selectable: true,
                              onTap: () {},
                            ),
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: FitnessColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state is NewTrainingMode
                                  ? LocaleKeys.new_training_page_add_exercise
                                      .tr()
                                  : LocaleKeys.new_template_page_add_exercise
                                      .tr(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                context
                                    .read<ExerciseEditCubit>()
                                    .changeMode(ExerciseCreateMode());
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(ExercisePage.route)
                                    .then((value) {
                                  print(value);
                                  if (value != null) {
                                    setState(() {
                                      _selectedExercises.add(value as Exercise);
                                    });
                                  }
                                });
                              },
                              child:
                                  const Icon(CupertinoIcons.add_circled_solid),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state is NewTrainingMode
                                    ? LocaleKeys.new_training_page_add_template
                                        .tr()
                                    : LocaleKeys.new_template_page_add_template
                                        .tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                CupertinoIcons.chevron_forward,
                                color: FitnessColors.blindGray,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 76,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _trainings.length,
                          itemBuilder: (context, index) {
                            return TemplateCard(
                              fixedWidth: 240,
                              template: _trainings[index],
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamed(ExercisesSearchPage.route).then((value) {
                            print(value);
                            if (value != null) {
                              setState(() {
                                _selectedExercises.add(value as Exercise);
                              });
                            }
                          });
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state is NewTrainingMode
                                    ? LocaleKeys.new_training_page_add_previous
                                        .tr()
                                    : LocaleKeys.new_template_page_add_previous
                                        .tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                CupertinoIcons.chevron_forward,
                                color: FitnessColors.blindGray,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 76,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _exercises.length,
                          itemBuilder: (context, index) {
                            return ExerciseCard(
                              marginTopDisabled: true,
                              fixedWidth: 240,
                              onTap: () {},
                              exercise: _exercises[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      _formKey.currentState!.validate();
                      if (_name.text.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text(
                                state is NewTrainingMode
                                    ? LocaleKeys.new_training_page_error_title
                                        .tr()
                                    : LocaleKeys.new_template_page_error_title
                                        .tr(),
                              ),
                              content: Text(
                                state is NewTrainingMode
                                    ? LocaleKeys
                                        .new_training_page_error_name_description
                                        .tr()
                                    : LocaleKeys.new_template_page_error_name
                                        .tr(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              actions: [
                                CupertinoButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    LocaleKeys
                                        .new_training_page_error_name_confirm
                                        .tr(),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      state is NewTrainingMode
                          ? LocaleKeys.new_training_page_create.tr()
                          : LocaleKeys.new_template_page_create.tr(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
