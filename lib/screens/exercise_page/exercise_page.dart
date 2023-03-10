import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/exercise_edit_cubit/exercise_edit_cubit.dart';
import 'package:trainings/common_widgets/field_tile.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/exercise.dart';

import 'widget/radio_item.dart';

List<String> units = [
  LocaleKeys.exercise_page_units_weight_reps.tr(),
  LocaleKeys.exercise_page_units_distance_time.tr(),
  LocaleKeys.exercise_page_units_reps_time.tr(),
  LocaleKeys.exercise_page_units_custom.tr(),
];

Exercise _templateExercise = Exercise(
  id: 0,
  title: 'Exercise Name',
  description: 'Distance (km)/Time (min)',
  reps: const [],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  static const String route = '/trainings/exercise';

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();

  int _selectedIndex = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() {
    bool valid = _formKey.currentState!.validate();
    if (valid) {
      Navigator.pop(context, _templateExercise);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseEditCubit, ExerciseEditState>(
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
              state is ExerciseEditMode
                  ? LocaleKeys.exercise_page_title_edit.tr()
                  : LocaleKeys.exercise_page_title_new.tr(),
            ),
            trailing: state is ExerciseEditMode
                ? CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _submitForm,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        LocaleKeys.exercise_page_edit.tr(),
                      ),
                    ),
                  )
                : null,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: FitnessColors.white,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(24),
                                bottomLeft: Radius.circular(24))),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 32),
                        child: Column(
                          children: [
                            FieldTile(
                              formKey: _formKey,
                              validator: (String? text) {
                                if (text == null || text.isEmpty || text == '') {
                                  return LocaleKeys.exercise_page_error_name_field
                                      .tr();
                                }
                                return null;
                              },
                              withBorder: true,
                              text: LocaleKeys.exercise_page_name.tr(),
                              controller: _name,
                            ),
                            FieldTile(
                              withBorder: true,
                              text: LocaleKeys.exercise_page_description.tr(),
                              controller: _description,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Text(
                          LocaleKeys.exercise_page_units_title.tr().toUpperCase(),
                          style: TextStyle(
                              fontSize: 12, color: FitnessColors.blindGray),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: FitnessColors.white,
                        ),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: units.length,
                          itemBuilder: (context, index) {
                            return RadioItem(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              index: index,
                              selectedIndex: _selectedIndex,
                              label: units[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 1,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                state is ExerciseEditMode ? const SizedBox() : Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _submitForm,
                    child: Text(
                      LocaleKeys.exercise_page_save.tr(),
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
