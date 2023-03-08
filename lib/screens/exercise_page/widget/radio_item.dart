import 'package:flutter/cupertino.dart';
import 'package:trainings/constants/colors.dart';

class RadioItem extends StatelessWidget {
  const RadioItem(
      {Key? key,
      required this.index,
      required this.selectedIndex,
      required this.label, required this.onTap})
      : super(key: key);

  final int index;
  final int selectedIndex;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
    );
  }
}
