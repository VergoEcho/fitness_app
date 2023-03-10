import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/exercise.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    Key? key,
    required this.exercise,
    required this.onTap,
    this.marginTopDisabled = false,
    this.fixedWidth,
    this.selectable = false,
  }) : super(key: key);

  final Exercise exercise;
  final VoidCallback onTap;
  final bool marginTopDisabled;
  final double? fixedWidth;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fixedWidth,
        margin: EdgeInsets.only(
          top: marginTopDisabled ? 0 : 16,
          left: 8,
          right: 8,
        ),
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: selectable ? FitnessColors.whiteBlue : FitnessColors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.title, style: const TextStyle(
                  fontSize: 16,
                ),),
                const SizedBox(height: 2),
                exercise.description == ""
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          exercise.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: FitnessColors.blindGray,
                          ),
                        ),
                      ),
              ],
            ),
            selectable
                ? const SizedBox()
                : CupertinoButton(
                    onPressed: null,
                child: SvgPicture.asset(
                  'assets/images/chevron-forward.svg',
                  height: 16,
                  width: 16,
                ),
                  )
          ],
        ),
      ),
    );
  }
}
