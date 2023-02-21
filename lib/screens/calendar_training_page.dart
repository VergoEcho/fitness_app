import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/models/training.dart';
import 'package:trainings/ui/filled_button.dart';
import 'package:trainings/widgets/calendar_exercise_card.dart';

Training _training = Training(
  id: 1,
  title: 'Arms day',
  description: 'Training focused on arms',
  date: DateTime.now(),
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

List<Exercise> _exercises = [
  Exercise(
    id: 2,
    title: 'Squats',
    description: '20 kg x 20 Reps',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: [],
  ),
  Exercise(
    id: 2,
    title: 'Leg stretches',
    description: '20 kg x 20 Reps',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: [],
  ),
];

class CalendarTrainingPage extends StatelessWidget {
  const CalendarTrainingPage({Key? key}) : super(key: key);

  static const route = '/calendar/training';

  @override
  Widget build(BuildContext context) {
    Map<String,Client> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, Client>;
    Client client = arguments['client']!;

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
                Icons.arrow_back_ios_new,
              ),
              Text(LocaleKeys.calendar_training_page_back.tr())
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text(client.name),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
              color: FitnessColors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _training.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    Text(DateFormat('dd.MM.yy', context.locale.languageCode)
                        .format(_training.date)
                        .toString())
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _training.description,
                  style: TextStyle(fontSize: 14, color: FitnessColors.blindGray),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 16,
                      ),
                      child: AppleFilledButton(
                        text:
                            LocaleKeys.calendar_training_page_new_template.tr(),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _exercises.length,
                  itemBuilder: (context, index) {
                    Exercise exercise = _exercises[index];
                    return CalendarExerciseCard(
                      exercise: exercise,
                    );
                  },
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
