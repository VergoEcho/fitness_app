import 'package:flutter/cupertino.dart';
import 'package:trainings/constants/colors.dart';

class FieldTile extends StatelessWidget {
  const FieldTile({Key? key, required this.text, this.controller, this.withBorder = false, this.onChanged, this.validator, this.formKey}) : super(key: key);

  final String text;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final bool withBorder;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;

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
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: CupertinoTextFormFieldRow(scrollPadding: EdgeInsets.zero,
              onChanged: onChanged,
              controller: controller,
              validator: validator,
              placeholder: "-",
              placeholderStyle: TextStyle(
                color: FitnessColors.black,
              ),
              style: TextStyle(
                color: FitnessColors.black,
                fontSize: 16,
              ),
              padding: const EdgeInsets.only(left: 0, right: 0, top: 4),
            ),
          )
        ],
      ),
    );
  }
}
