import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainings/constants/colors.dart';

class FieldTile extends StatelessWidget {
  const FieldTile(
      {Key? key,
      required this.text,
      this.controller,
      this.withBorder = false,
      this.onChanged,
      this.validator,
      this.formKey,
      this.onTap})
      : super(key: key);

  final String text;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final bool withBorder;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;
  final VoidCallback? onTap;

  Border? fieldBorder() {
    return withBorder ? Border.all(color: FitnessColors.blindGray) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        border: fieldBorder(),
        color: FitnessColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              text,
              style: TextStyle(
                color: FitnessColors.blindGray,
                fontSize: 16,
              ),
            ),
          ),
          Form(
            key: formKey,
            child: CupertinoTextFormFieldRow(
              onTap: onTap,
              scrollPadding: EdgeInsets.zero,
              onChanged: onChanged,
              controller: controller,
              validator: validator,
              placeholder: "-",
              placeholderStyle: TextStyle(
                color: FitnessColors.black,
              ),
              style: GoogleFonts.inter(
                color: FitnessColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              padding: const EdgeInsets.only(left: 0, right: 0, top: 4),
            ),
          )
        ],
      ),
    );
  }
}
