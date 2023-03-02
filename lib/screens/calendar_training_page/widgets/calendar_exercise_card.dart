import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/screens/calendar_training_page/widgets/double_picker.dart';
import 'package:trainings/screens/calendar_training_page/widgets/set_card.dart';

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
        editable: true,
        togglePicker: () {
          setState(() {
            _doublePickerExpanded = !_doublePickerExpanded;
          });
        },
      );
    }
    return CupertinoButton(
      onPressed: () {
        setState(() {
          _todayCardActive = !_todayCardActive;
          _doublePickerExpanded = !_doublePickerExpanded;
        });
      },
      child: const Icon(
        CupertinoIcons.add_circled_solid,
        size: 32,
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
                                    fontSize: 14, color: FitnessColors.darkGray),
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
                      const SetCard(),
                      const SetCard(),
                      const SetCard(),
                    ],
                  ),
                ),
                DoublePicker(expanded: _doublePickerExpanded)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
