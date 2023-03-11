import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/client_edit_cubit/client_edit_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/client.dart';

import 'day_selector.dart';

class DayTimePicker extends StatefulWidget {
  const DayTimePicker({
    Key? key,
    required this.selectedDayExpandController,
    required this.timeExpandController,
    required this.onDaySelectorPressed,
    required this.onTimePressed,
    required this.onDateTimeChanged,
  }) : super(key: key);

  final AnimationController selectedDayExpandController;
  final AnimationController timeExpandController;
  final Function(String day) onDaySelectorPressed;
  final VoidCallback onTimePressed;
  final Function(DateTime date) onDateTimeChanged;

  @override
  State<DayTimePicker> createState() => _DayTimePickerState();
}

class _DayTimePickerState extends State<DayTimePicker>
    with TickerProviderStateMixin {
  late Animation<double> selectedDayExpandAnimation;
  late Animation<double> timeExpandAnimation;

  TimeOfDay _selectedDayTime(ClientEditState state) {
    return state.client.trainingDays[state.selectedDay] ??
        const TimeOfDay(hour: 0, minute: 00);
  }

  String _selectedDayTimeString(ClientEditState state) {
    TimeOfDay time = _selectedDayTime(state);
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    selectedDayExpandAnimation = CurvedAnimation(
      parent: widget.selectedDayExpandController,
      curve: Curves.fastOutSlowIn,
    );

    timeExpandAnimation = CurvedAnimation(
      parent: widget.timeExpandController,
      curve: Curves.fastOutSlowIn,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientEditCubit, ClientEditState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: FitnessColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.client_edit_page_schedule.tr(),
                style: TextStyle(
                  fontSize: 16,
                  color: FitnessColors.blindGray,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: state.client.trainingDays.entries.map((day) {
                    return DaySelector(
                      clearTime: () {
                        Client client = state.client;
                        client.trainingDays[day.key] = null;
                        context.read<ClientEditCubit>().update(client);
                      },
                      time: day.value,
                      selectedDay: state.selectedDay,
                      onPressed: () => widget.onDaySelectorPressed(day.key),
                      day: day.key.substring(0, 3),
                    );
                  }).toList(),
                ),
              ),
              SizeTransition(
                sizeFactor: selectedDayExpandAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.client_edit_page_time.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.all(8),
                        color: FitnessColors.whiteShaded,
                        onPressed: widget.onTimePressed,
                        child: Text(
                          _selectedDayTimeString(state),
                          style: TextStyle(
                            color: FitnessColors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizeTransition(
                sizeFactor: timeExpandAnimation,
                child: SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: widget.onDateTimeChanged,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}