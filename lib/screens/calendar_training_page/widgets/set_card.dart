import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/exercise_set.dart';
import 'package:trainings/models/series.dart';

class SetCard extends StatefulWidget {
  const SetCard({
    Key? key,
    this.editable = false,
    this.togglePicker,
    required this.exerciseSet,
    this.selectedSeriesId,
    this.addNewSeries,
    this.changeSeriesId,
    this.removeSeriesById,
  }) : super(key: key);

  final bool editable;
  final Function({required bool expanded})? togglePicker;
  final ExerciseSet exerciseSet;
  final String? selectedSeriesId;
  final VoidCallback? addNewSeries;
  final Function({String? seriesId})? changeSeriesId;
  final Function(String seriesId)? removeSeriesById;

  @override
  State<SetCard> createState() => _SetCardState();
}

class _SetCardState extends State<SetCard> {
  List<Widget> _getSeriesRows() {
    List<Widget> rows = [];
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    for (Series series in widget.exerciseSet.series) {
      rows.add(
        widget.editable
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: widget.selectedSeriesId == series.id
                      ? FitnessColors.white
                      : null,
                ),
                padding: const EdgeInsets.only(
                  right: 12,
                  top: 4,
                  bottom: 4,
                ),
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: SizedBox(
                  height: 22,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 32,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: widget.selectedSeriesId == series.id
                              ? () {
                                  widget.removeSeriesById!(series.id);
                                  widget.togglePicker!(expanded: false);
                                }
                              : null,
                          child: Icon(
                            CupertinoIcons.minus_circle_fill,
                            color: widget.selectedSeriesId == series.id
                                ? FitnessColors.red
                                : FitnessColors.red.withOpacity(0),
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (widget.selectedSeriesId == series.id) {
                            widget.changeSeriesId!();
                            widget.togglePicker!(expanded: false);
                          } else {
                            widget.changeSeriesId!(seriesId: series.id);
                            widget.togglePicker!(expanded: true);
                          }
                        },
                        child: Text(
                          '${series.effort.toString().replaceAll(regex, '')} kg x ${series.quantity} Reps',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: widget.selectedSeriesId == series.id
                                ? FitnessColors.black
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    right: 16, left: 16, top: 8.0, bottom: 5),
                child: Text(
                  '${series.effort.toString().replaceAll(regex, '')} kg x ${series.quantity} Reps',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
      );
    }
    return rows;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 16),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: FitnessColors.whiteBlue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              ..._getSeriesRows(),
            ],
          ),
        ),
        Positioned(
          left: 4,
          top: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
                color: FitnessColors.primary,
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              widget.editable
                  ? LocaleKeys.calendar_training_page_today.tr().toUpperCase()
                  : DateFormat('dd.MM.yy', context.locale.languageCode)
                      .format(DateTime.now()),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: FitnessColors.white,
              ),
            ),
          ),
        ),
        widget.editable
            ? Positioned(
                right: 12,
                top: -4,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (widget.selectedSeriesId == null) {
                      setState(() {
                        widget.addNewSeries!();
                        widget.togglePicker!(expanded: true);
                      });
                    } else {
                      widget.changeSeriesId!();
                      widget.togglePicker!(expanded: false);
                    }
                  },
                  child: widget.selectedSeriesId == null
                      ? const Icon(
                          CupertinoIcons.add_circled_solid,
                          size: 32,
                        )
                      : Icon(
                          CupertinoIcons.checkmark_alt_circle_fill,
                          color: FitnessColors.lightGreen,
                          size: 32,
                        ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
