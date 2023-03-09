import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';

class DaySelector extends StatelessWidget {
  const DaySelector(
      {Key? key,
      required this.onPressed,
      required this.day,
      this.time,
      required this.selectedDay, required this.clearTime})
      : super(key: key);

  final VoidCallback onPressed;
  final VoidCallback clearTime;
  final String day;
  final TimeOfDay? time;
  final String selectedDay;

  Color? _containerColor() {
    if (selectedDay.length >= 3) {
      if (selectedDay.substring(0, 3) == day) {
        return FitnessColors.primary;
      }
    }
    if (time != null) {
      return FitnessColors.whiteShaded;
    }
    return null;
  }

  Color? _textColor() {
    if (selectedDay.length >= 3) {
      if (selectedDay.substring(0, 3) == day) {
        return FitnessColors.white;
      }
    }
    if (time != null) {
      return FitnessColors.black;
    }
    return FitnessColors.ghostGray;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 36,
            width: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: _containerColor(),
            ),
            child: Text(
              day.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _textColor(),
              ),
            ),
          ),
        ),
        time != null
            ? Positioned(
                right: -8,
                top: -12,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    onPressed: clearTime,
                    child: Icon(
                      CupertinoIcons.minus_circle_fill,
                      color: FitnessColors.red,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
