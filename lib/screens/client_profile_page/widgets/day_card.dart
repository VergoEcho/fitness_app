import 'package:flutter/cupertino.dart';
import 'package:trainings/constants/colors.dart';

class DayCard extends StatelessWidget {
  const DayCard({
    Key? key,
    required this.day,
    this.time,
  }) : super(key: key);

  final String? time;
  final String day;

  Color? _boxColor() {
    return time != null ? FitnessColors.primary : null;
  }

  Color? _textColor() {
    return time != null ? FitnessColors.white : FitnessColors.ghostGray;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: _boxColor(),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            day.toUpperCase(),
            style: TextStyle(
              color: _textColor(),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          time != null
              ? Text(
                  time!,
                  style: TextStyle(
                    color: FitnessColors.white.withOpacity(.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
