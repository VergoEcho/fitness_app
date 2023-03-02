import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/exercise.dart';

import 'widgets/exercise_search_item.dart';

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

class ExercisesSearchPage extends StatelessWidget {
  const ExercisesSearchPage({Key? key}) : super(key: key);

  static const String route = '/exercises/search';

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
          onPressed: () {},
          child: const Icon(CupertinoIcons.add_circled_solid,),
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
              padding: const EdgeInsets.only(
                  top: 8, left: 16, right: 16, bottom: 32),
              child: const CupertinoSearchTextField(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExerciseSearchItem(
                    exercise: _exercises[index],
                    onTap: () {},
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
                right: 16,
                left: 16,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {},
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
