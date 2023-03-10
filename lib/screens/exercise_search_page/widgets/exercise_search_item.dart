import 'package:flutter/cupertino.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/exercise.dart';

class ExerciseSearchItem extends StatelessWidget {
  const ExerciseSearchItem(
      {Key? key,
      required this.onTap,
      required this.exercise,
      required this.index,
      required this.selectedIndex})
      : super(key: key);

  final VoidCallback onTap;
  final Exercise exercise;
  final int index;
  final int? selectedIndex;

  Color _borderColor() {
    return selectedIndex == index
        ? FitnessColors.primary
        : FitnessColors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FitnessColors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: _borderColor(),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.title),
                const SizedBox(height: 2),
                exercise.description == ""
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          exercise.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: FitnessColors.darkGray,
                          ),
                        ),
                      ),
              ],
            ),
            selectedIndex == index
                ? Icon(
                    CupertinoIcons.checkmark,
                    color: FitnessColors.primary,
                    size: 16,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
