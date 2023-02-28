import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
// import 'package:trainings/models/client.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/models/training.dart';
import 'package:trainings/common_widgets/filled_button.dart';
import 'package:trainings/screens/calendar_training_page/widgets/calendar_exercise_card.dart';

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
    reps: const [],
  ),
  Exercise(
    id: 2,
    title: 'Leg stretches',
    description: '20 kg x 20 Reps',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [],
  ),
];

class CalendarTrainingPage extends StatelessWidget {
  const CalendarTrainingPage({Key? key}) : super(key: key);

  static const route = '/calendar/training';

  @override
  Widget build(BuildContext context) {
    // Map<String, Client> arguments =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, Client>;
    // Client client = arguments['client']!;

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
              const SizedBox(width: 4),
              Text(LocaleKeys.calendar_training_page_back.tr())
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text(LocaleKeys.calendar_training_page_client_name.tr()),
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
                  LocaleKeys.calendar_training_page_training_name.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/calendar.svg',
                        height: 16,
                        width: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                            DateFormat('dd.MM.yy', context.locale.languageCode)
                                .format(_training.date)
                                .toString()),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    LocaleKeys.calendar_training_page_training_notes.tr(),
                    style:
                        TextStyle(fontSize: 14, color: FitnessColors.blindGray),
                  ),
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
                            LocaleKeys.calendar_training_page_new_exercise.tr(),
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
                    return CalendarExerciseCard(exercise: _exercises[index]);
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
