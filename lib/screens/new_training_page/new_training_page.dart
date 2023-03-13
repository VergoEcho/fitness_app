import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/exercise_edit_cubit/exercise_edit_cubit.dart';
import 'package:trainings/bloc/exercises_cubit/exercises_cubit.dart';
import 'package:trainings/bloc/new_training_cubit/new_training_cubit.dart';
import 'package:trainings/bloc/search_cubit/search_cubit.dart';
import 'package:trainings/bloc/trainings_cubit/trainings_cubit.dart';
import 'package:trainings/common_widgets/field_tile.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/screens/exercise_page/exercise_page.dart';
import 'package:trainings/screens/exercise_search_page/exercises_search_page.dart';
import 'package:trainings/screens/trainings_page/widgets/exercise_card.dart';

import 'widgets/template_card.dart';

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

  String _titleText(BuildContext context) {
    return context.read<NewTrainingCubit>().state is NewTrainingMode
        ? LocaleKeys.new_training_page_title.tr()
        : LocaleKeys.new_template_page_title.tr();
  }

  String? _nameValidator(String? text) {
    if (text == null || text.isEmpty || text == '') {
      return context.read<NewTrainingCubit>().state is NewTrainingMode
          ? LocaleKeys.new_training_page_error_name_field.tr()
          : LocaleKeys.new_template_page_error_name_field.tr();
    }
    return null;
  }

  String _nameLabelText() {
    return context.read<NewTrainingCubit>().state is NewTrainingMode
        ? LocaleKeys.new_training_page_name.tr()
        : LocaleKeys.new_template_page_name.tr();
  }

  String _descriptionLabelText() {
    return context.read<NewTrainingCubit>().state is NewTrainingMode
        ? LocaleKeys.new_training_page_description.tr()
        : LocaleKeys.new_template_page_description.tr();
  }

  Widget? _selectableExerciseCardBuilder(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ExerciseCard(
        exercise: _selectedExercises[index],
        selectable: true,
        onTap: () {},
      ),
    );
  }

  String _addExerciseText(BuildContext context) {
    return context.read<NewTrainingCubit>().state is NewTrainingMode
        ? LocaleKeys.new_training_page_add_exercise.tr()
        : LocaleKeys.new_template_page_add_exercise.tr();
  }

  _addNewExercise() {
    context.read<ExerciseEditCubit>().changeMode(ExerciseCreateMode());
    Navigator.of(context, rootNavigator: true)
        .pushNamed(ExercisePage.route)
        .then((value) {
      if (value != null) {
        setState(() {
          _selectedExercises.add(value as Exercise);
        });
      }
    });
  }

  String _addTemplateText(BuildContext context) {
    return context.read<NewTrainingCubit>().state is NewTrainingMode
        ? LocaleKeys.new_training_page_add_template.tr()
        : LocaleKeys.new_template_page_add_template.tr();
  }

  Widget? _templateCardBuilder(BuildContext context, int index) {
    return TemplateCard(
      fixedWidth: 240,
      template: context.read<TrainingsCubit>().state.trainings[index],
      onTap: () {},
    );
  }

  _openExerciseSearch() {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(ExercisesSearchPage.route).then((value) {
      context.read<SearchCubit>().clear();
      if (value != null) {
        setState(() {
          _selectedExercises.add(value as Exercise);
        });
      }
    });
  }

  String _addPreviousText (BuildContext context) {
    return context.read<NewTrainingCubit>().state is NewTrainingMode
        ? LocaleKeys.new_training_page_add_previous
        .tr()
        : LocaleKeys.new_template_page_add_previous
        .tr();
  }

  Widget? _exerciseCardBuilder(BuildContext context, int index) {
    return ExerciseCard(
      marginTopDisabled: true,
      fixedWidth: 240,
      onTap: () {},
      exercise: context.read<ExercisesCubit>().state.exercises[index],
    );
  }

  _submit() {
    bool valid = _formKey.currentState!.validate();
    if (valid) {
      Navigator.pop(context);
    }
  }

  _submitText(BuildContext context) {
    return context.read<NewTrainingCubit>().state is NewTrainingMode
        ? LocaleKeys.new_training_page_create.tr()
        : LocaleKeys.new_template_page_create.tr();
  }

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
              onPressed: () => Navigator.pop(context),
            ),
            middle: Text(_titleText(context)),
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
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                  child: Column(
                    children: [
                      FieldTile(
                        formKey: _formKey,
                        validator: _nameValidator,
                        withBorder: true,
                        text: _nameLabelText(),
                        controller: _name,
                      ),
                      FieldTile(
                        withBorder: true,
                        text: _descriptionLabelText(),
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
                        itemBuilder: _selectableExerciseCardBuilder,
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
                              _addExerciseText(context),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            CupertinoButton(
                              onPressed: _addNewExercise,
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
                                _addTemplateText(context),
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
                        child: BlocBuilder<TrainingsCubit, TrainingsState>(
                          builder: (context, state) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.trainings.length,
                              itemBuilder: _templateCardBuilder,
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: _openExerciseSearch,
                        behavior: HitTestBehavior.translucent,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _addPreviousText(context),
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
                        child: BlocBuilder<ExercisesCubit, ExercisesState>(
                          builder: (context, state) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.exercises.length,
                              itemBuilder: _exerciseCardBuilder,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 32),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _submit,
                    child: Text(
                      _submitText(context),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
