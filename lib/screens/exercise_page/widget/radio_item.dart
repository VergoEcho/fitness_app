import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';

class RadioItem extends StatelessWidget {
  const RadioItem(
      {Key? key,
      required this.index,
      required this.selectedIndex,
      required this.label})
      : super(key: key);

  final int index;
  final int selectedIndex;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        index == 0 ? const SizedBox() : const Divider(),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Icon(
                CupertinoIcons.checkmark,
                size: 24,
                color: FitnessColors.primary.withOpacity(
                  index == selectedIndex ? 1 : 0,
                ),
              ),
            ),
            Text(label),
          ],
        ),
      ],
    );
  }
}
