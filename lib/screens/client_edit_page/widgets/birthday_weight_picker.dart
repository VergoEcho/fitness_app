import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';

class BirthdayWeightPicker extends StatefulWidget {
  const BirthdayWeightPicker({
    Key? key,
    required this.onBirthdayTapped,
    required this.birthday,
    required this.birthdayExpanded,
    required this.birthdayExpandController,
    required this.onBirthdayDateChanged,
    required this.initialBirthdayDate,
    required this.weightExpandController,
    required this.weight,
    required this.initialWeight,
    required this.onWeightTapped,
    required this.weightExpanded,
    required this.onWeightValueChanged,
  }) : super(key: key);

  final DateTime birthday;
  final DateTime initialBirthdayDate;
  final VoidCallback onBirthdayTapped;
  final bool birthdayExpanded;
  final AnimationController birthdayExpandController;
  final Function(DateTime) onBirthdayDateChanged;

  final double weight;
  final int initialWeight;
  final VoidCallback onWeightTapped;
  final bool weightExpanded;
  final Function(int) onWeightValueChanged;
  final AnimationController weightExpandController;

  @override
  State<BirthdayWeightPicker> createState() => _BirthdayWeightPickerState();
}

class _BirthdayWeightPickerState extends State<BirthdayWeightPicker> {
  late Animation<double> birthdayExpandAnimation;
  late Animation<double> weightExpandAnimation;

  @override
  void initState() {
    birthdayExpandAnimation = CurvedAnimation(
      parent: widget.birthdayExpandController,
      curve: Curves.fastOutSlowIn,
    );
    weightExpandAnimation = CurvedAnimation(
      parent: widget.weightExpandController,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: FitnessColors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.onBirthdayTapped,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.client_edit_page_birthday.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat('dd MMM yyy', context.locale.languageCode)
                            .format(widget.birthday),
                        style: TextStyle(
                            color: FitnessColors.blindGray, fontSize: 16),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: null,
                        child: AnimatedRotation(
                          turns: widget.birthdayExpanded ? .25 : 0,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(
                            CupertinoIcons.chevron_forward,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: birthdayExpandAnimation,
            child: SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: widget.initialBirthdayDate,
                dateOrder: DatePickerDateOrder.dmy,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: widget.onBirthdayDateChanged,
              ),
            ),
          ),
          const Divider(
            height: 0,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.onWeightTapped,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.client_edit_page_weight.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.weight.toInt().toString(),
                        style: TextStyle(
                            color: FitnessColors.blindGray, fontSize: 16),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: null,
                        child: AnimatedRotation(
                          turns: widget.weightExpanded ? .25 : 0,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(
                            CupertinoIcons.chevron_forward,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: weightExpandAnimation,
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: widget.initialWeight,
                ),
                itemExtent: 32,
                onSelectedItemChanged: widget.onWeightValueChanged,
                children: List<Widget>.generate(300, (int index) {
                  return Center(
                    child: Text(
                      '${index + 1} kg',
                      style: TextStyle(
                        color: FitnessColors.black,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}