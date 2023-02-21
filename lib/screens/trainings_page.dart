import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/training.dart';
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
    reps: [],
  ),
];

enum TemplateOrExercise { template, exercise }

class TrainingsPage extends StatefulWidget {
  const TrainingsPage({Key? key}) : super(key: key);

  static const String route = '/trainings';

  @override
  State<TrainingsPage> createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingsPage> {
  TemplateOrExercise pageMode = TemplateOrExercise.template;

  List _selectedList() {
    if (pageMode == TemplateOrExercise.template) {
      return _templates;
    }
    return _exercises;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xfffafafa),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.all(
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
                      CupertinoButton.filled(
                        borderRadius: BorderRadius.circular(100),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        minSize: 32,
                        onPressed: () {},
                        child: Text(
                          LocaleKeys.trainings_page_new_template
                              .tr()
                              .toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const CupertinoSearchTextField(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl<TemplateOrExercise>(
                      groupValue: pageMode,
                      children: <TemplateOrExercise, Widget>{
                        TemplateOrExercise.template:
                            Text(LocaleKeys.trainings_page_templates.tr()),
                        TemplateOrExercise.exercise:
                            Text(LocaleKeys.trainings_page_exercises.tr()),
                      },
                      onValueChanged: (state) {
                        setState(() {
                          if (pageMode != state) {
                            pageMode = state!;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _selectedList().length,
                itemBuilder: (context, index) {
                  if (pageMode == TemplateOrExercise.template) {
                    Training item = _selectedList()[index];
                    return TrainingTemplateCard(
                      template: item,
                    );
                  }
                  Exercise item = _selectedList()[index];
                  return ExerciseCard(exercise: item);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
