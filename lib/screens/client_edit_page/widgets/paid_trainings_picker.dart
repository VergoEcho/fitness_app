import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';

class PaidTrainingsPicker extends StatefulWidget {
  const PaidTrainingsPicker(
      {Key? key,
        required this.expanded,
        required this.onTap,
        required this.paidTrainings,
        required this.expandController,
        required this.onSelectedItemChanged})
      : super(key: key);

  final bool expanded;
  final VoidCallback onTap;
  final int paidTrainings;
  final AnimationController expandController;
  final Function(int index) onSelectedItemChanged;

  @override
  State<PaidTrainingsPicker> createState() => _PaidTrainingsPickerState();
}

class _PaidTrainingsPickerState extends State<PaidTrainingsPicker> {
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    _expandAnimation = CurvedAnimation(
      parent: widget.expandController,
      curve: Curves.fastOutSlowIn,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: FitnessColors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.client_edit_page_paid_training.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.paidTrainings.toString(),
                      style: TextStyle(
                        color: FitnessColors.blindGray,
                        fontSize: 16,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: null,
                      child: AnimatedRotation(
                        turns: widget.expanded ? .25 : 0,
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
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: widget.paidTrainings,
                ),
                itemExtent: 32,
                onSelectedItemChanged: widget.onSelectedItemChanged,
                children: List<Widget>.generate(100, (int index) {
                  return Center(
                    child: Text(
                      '$index paid',
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
