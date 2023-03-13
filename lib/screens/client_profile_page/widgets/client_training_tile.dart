import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/training.dart';

class ClientTrainingTile extends StatelessWidget {
  const ClientTrainingTile({
    super.key,
    required this.onTap,
    required this.training,
  });

  final Training training;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16,),
        decoration: BoxDecoration(
          color: FitnessColors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  training.title,
                  style: const TextStyle(fontSize: 16),
                ),
                training.description == ""
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          training.description,
                          style: TextStyle(
                              fontSize: 14, color: FitnessColors.blindGray),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/calendar.svg',
                        height: 16,
                        width: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          DateFormat('dd.MM.yy', context.locale.languageCode)
                              .format(DateTime.now())
                              .toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
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
            ),
          ],
        ),
      ),
    );
  }
}
