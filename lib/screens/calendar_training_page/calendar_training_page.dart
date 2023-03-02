import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainings/bloc/calendar_page_cubit/calendar_page_cubit.dart';
import 'package:trainings/bloc/exercises_cubit/exercises_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/common_widgets/filled_button.dart';
import 'package:trainings/screens/calendar_training_page/widgets/calendar_exercise_card.dart';

class CalendarTrainingPage extends StatelessWidget {
  const CalendarTrainingPage({Key? key}) : super(key: key);

  static const route = '/calendar/training';

  String _getDate (BuildContext context) {
    DateTime selectedDate = context.read<CalendarPageCubit>().state.selectedDay;
    return DateFormat('dd.MM.yy', context.locale.languageCode)
        .format(selectedDate)
        .toString();
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
                        child: Text(_getDate(context)),
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
                BlocBuilder<ExercisesCubit, ExercisesState>(
                  builder: (context, state) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.exercises.length,
                      itemBuilder: (context, index) {
                        return CalendarExerciseCard(
                            exercise: state.exercises[index]);
                      },
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
