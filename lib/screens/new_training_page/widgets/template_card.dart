import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/training.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard(
      {Key? key,
      required this.template,
      required this.onTap,
      this.fixedWidth,})
      : super(key: key);

  final Training template;
  final VoidCallback onTap;
  final double? fixedWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fixedWidth,
        margin: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16,),
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
                Text(template.title),
                const SizedBox(height: 2),
                template.description == ""
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          template.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: FitnessColors.darkGray,
                          ),
                        ),
                      ),
              ],
            ),
            CupertinoButton(
              onPressed: null,
              child: Icon(
                Icons.arrow_forward_ios,
                color: FitnessColors.darkGray,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
