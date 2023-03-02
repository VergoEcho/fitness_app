import 'package:flutter/cupertino.dart';
import 'package:trainings/constants/colors.dart';

class FieldTile extends StatelessWidget {
  const FieldTile({Key? key, required this.text, required this.controller, this.withBorder = false}) : super(key: key);

  final String text;
  final TextEditingController controller;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: withBorder ? Border.all(color: FitnessColors.blindGray) : null,
        color: FitnessColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: FitnessColors.blindGray,
              fontSize: 16,
            ),
          ),
          CupertinoTextField.borderless(
            controller: controller,
            placeholder: "-",
            placeholderStyle: TextStyle(
              color: FitnessColors.black,
            ),
            style: TextStyle(
              color: FitnessColors.black,
              fontSize: 16,
            ),
            padding: const EdgeInsets.only(left: 0, right: 0, top: 4),
          )
        ],
      ),
    );
  }
}