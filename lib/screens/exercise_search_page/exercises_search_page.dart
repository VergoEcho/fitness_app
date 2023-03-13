import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/exercise_edit_cubit/exercise_edit_cubit.dart';
import 'package:trainings/bloc/exercises_cubit/exercises_cubit.dart';
import 'package:trainings/bloc/search_cubit/search_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/screens/exercise_page/exercise_page.dart';

import 'widgets/exercise_search_item.dart';

class ExercisesSearchPage extends StatefulWidget {
  const ExercisesSearchPage({Key? key}) : super(key: key);

  static const String route = '/exercises/search';

  @override
  State<ExercisesSearchPage> createState() => _ExercisesSearchPageState();
}

class _ExercisesSearchPageState extends State<ExercisesSearchPage> {
  int? _selectedIndex;
  TextEditingController searchController = TextEditingController();

  List<Exercise> exercisesList(BuildContext context) {
    String search = context.read<SearchCubit>().state;
    List<Exercise> exercises = context.read<ExercisesCubit>().state.exercises;
    return exercises.where((exercise) {
      return exercise.title.toLowerCase().contains(search.toLowerCase());
    }).toList();
  }

  void _createNewExercise() {
    context.read<ExerciseEditCubit>().changeMode(ExerciseCreateMode());
    Navigator.of(context, rootNavigator: true)
        .pushNamed(ExercisePage.route)
        .then((value) {
      if (value != null) {
        Navigator.pop(context, value);
      }
    });
  }

  void _onSearchChanged(value) {
    if (_selectedIndex != null) {
      setState(() {
        _selectedIndex = null;
      });
    }
    context.read<SearchCubit>().update(value);
  }

  void _clearSearch() {
    context.read<SearchCubit>().clear();
    searchController.clear();
  }

  void _selectExercise() {
    context.read<ExerciseEditCubit>().changeMode(ExerciseCreateMode());
    Navigator.of(context, rootNavigator: true)
        .pushNamed(ExercisePage.route)
        .then((value) {
      if (value != null) {
        Navigator.pop(context, value);
      }
    });
  }

  Widget? _exerciseCardBuilder(BuildContext context, int index) {
    return ExerciseSearchItem(
      index: index,
      selectedIndex: _selectedIndex,
      exercise: exercisesList(context)[index],
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  VoidCallback? _addExercise(BuildContext context) {
    return _selectedIndex != null
        ? () {
            Navigator.pop(context, templateExercise);
          }
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: FitnessColors.whiteGray,
      navigationBar: CupertinoNavigationBar(
        border: Border.all(width: 0, color: FitnessColors.white),
        backgroundColor: FitnessColors.white,
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 0),
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
          LocaleKeys.search_exercise_page_title.tr(),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _createNewExercise,
          child: const Icon(
            CupertinoIcons.add_circled_solid,
            opticalSize: 20,
          ),
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
                  bottomLeft: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,
                bottom: 32,
              ),
              child: BlocBuilder<SearchCubit, String>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: CupertinoSearchTextField(
                          controller: searchController,
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
                          onSuffixTap: () {},
                          onChanged: _onSearchChanged,
                        ),
                      ),
                      state.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: 36,
                              child: CupertinoButton(
                                padding: const EdgeInsets.only(left: 14),
                                onPressed: _clearSearch,
                                child:
                                    Text(LocaleKeys.exercise_page_cancel.tr()),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
            BlocBuilder<SearchCubit, String>(
              builder: (context, state) {
                return exercisesList(context).isEmpty
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: Text(
                                LocaleKeys
                                    .search_exercise_page_no_exercise_label
                                    .tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: FitnessColors.blindGray,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: FitnessColors.primary,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 72),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                onPressed: _selectExercise,
                                child: Text(
                                  LocaleKeys.search_exercise_page_new_exercise
                                      .tr(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 160,
                            )
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: exercisesList(context).length,
                          itemBuilder: _exerciseCardBuilder,
                        ),
                      );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
                right: 16,
                left: 16,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: _addExercise(context),
                child: Text(
                  LocaleKeys.search_exercise_page_add.tr(),
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
  }
}
