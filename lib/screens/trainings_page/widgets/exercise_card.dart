import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/exercise.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({Key? key, required this.exercise}) : super(key: key);

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FitnessColors.white,
        borderRadius: BorderRadius.circular(13),
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
          CupertinoButton(
            onPressed: () {},
            child: Icon(
              Icons.arrow_forward_ios,
              color: FitnessColors.darkGray,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
