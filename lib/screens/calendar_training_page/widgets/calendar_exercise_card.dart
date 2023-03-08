import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/models/exercise_set.dart';
import 'package:trainings/models/series.dart';
import 'package:trainings/screens/calendar_training_page/widgets/double_picker.dart';
import 'package:trainings/screens/calendar_training_page/widgets/set_card.dart';
import 'package:uuid/uuid.dart';

List<ExerciseSet> setList = [
  ExerciseSet(
    id: 0,
    series: [
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
    ],
    createdAt: DateTime.now(),
  ),
  ExerciseSet(
    id: 1,
    series: [
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
    ],
    createdAt: DateTime.now(),
  ),
  ExerciseSet(
    id: 2,
    series: [
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
      Series(id: '0', effort: 20, quantity: 20),
    ],
    createdAt: DateTime.now(),
  ),
];

ExerciseSet newExerciseSet = ExerciseSet(
  id: setList.length,
  createdAt: DateTime.now(),
  series: [Series(id: "0", effort: 20, quantity: 10)],
);

class CalendarExerciseCard extends StatefulWidget {
  const CalendarExerciseCard({Key? key, required this.exercise})
      : super(key: key);

  final Exercise exercise;

  @override
  State<CalendarExerciseCard> createState() => _CalendarExerciseCardState();
}

class _CalendarExerciseCardState extends State<CalendarExerciseCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  bool _doublePickerExpanded = false;
  bool _todayCardActive = false;

  late final AnimationController _controller;
  late final Animation<double> _expandCardAnimation;

  String? selectedSeriesId = '0';

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _expandCardAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  todaySwitcher() {
    if (_todayCardActive) {
      return SetCard(
        addNewSeries: () {
          Uuid id = const Uuid();
          Series newSeries = Series(
            id: id.v1(),
            effort: 10,
            quantity: 10,
          );
          newExerciseSet.series.add(newSeries);
          setState(() {
            selectedSeriesId = newSeries.id;
          });
        },
        changeSeriesId: ({String? seriesId}) {
          setState(() {
            selectedSeriesId = seriesId;
          });
        },
        selectedSeriesId: selectedSeriesId,
        editable: true,
        togglePicker: ({required bool expanded}) {
          setState(() {
            _doublePickerExpanded = expanded;
          });
        },
        removeSeriesById: (String id) {
          Series series =
              newExerciseSet.series.firstWhere((series) => series.id == id);
          int seriesIndex = newExerciseSet.series.indexOf(series);
          if (newExerciseSet.series.length <= 1) {
            setState(() {
              _todayCardActive = false;
            });
          } else {
            setState(() {
              newExerciseSet.series.removeAt(seriesIndex);
            });
          }
        },
        exerciseSet: newExerciseSet,
      );
    }
    return SizedBox(
      height: 160,
      child: CupertinoButton(
        onPressed: () {
          setState(() {
            _todayCardActive = true;
            selectedSeriesId = '0';
            _doublePickerExpanded = !_doublePickerExpanded;
          });
        },
        child: const Icon(
          CupertinoIcons.add_circled_solid,
          size: 32,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FitnessColors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
              if (_expanded) {
                _controller.forward();
              } else {
                _controller.reverse();
                _doublePickerExpanded = false;
              }
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.exercise.title),
                      widget.exercise.description == ""
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                widget.exercise.description,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: FitnessColors.darkGray),
                              ),
                            ),
                    ],
                  ),
                ),
                CupertinoButton(
                  onPressed: null,
                  child: AnimatedRotation(
                    turns: _expanded ? .25 : 0,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: FitnessColors.darkGray,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _expandCardAnimation,
            child: Column(
              children: [
                const Divider(),
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        switchInCurve: Curves.easeInOut,
                        switchOutCurve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child: todaySwitcher(),
                      ),
                      ...setList.map((exerciseSet) {
                        return SetCard(
                          exerciseSet: exerciseSet,
                        );
                      }).toList()
                    ],
                  ),
                ),
                DoublePicker(
                  expanded: _doublePickerExpanded,
                  onEffortChanged: (int? index) {
                    Series series = newExerciseSet.series
                        .firstWhere((series) => series.id == selectedSeriesId);
                    int seriesIndex = newExerciseSet.series.indexOf(series);
                    setState(() {
                      newExerciseSet.series[seriesIndex] = Series(
                        id: series.id,
                        effort: index!.toDouble(),
                        quantity: series.quantity,
                      );
                    });
                  },
                  onQuantityChanged: (int? index) {
                    Series series = newExerciseSet.series
                        .firstWhere((series) => series.id == selectedSeriesId);
                    int seriesIndex = newExerciseSet.series.indexOf(series);
                    setState(() {
                      newExerciseSet.series[seriesIndex] = Series(
                        id: series.id,
                        effort: series.effort,
                        quantity: index! + 1,
                      );
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
