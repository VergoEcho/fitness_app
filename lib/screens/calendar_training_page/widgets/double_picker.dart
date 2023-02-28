import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';

class DoublePicker extends StatefulWidget {
  const DoublePicker({
    super.key,
    required this.expanded,
  });

  final bool expanded;

  @override
  State<DoublePicker> createState() => _DoublePickerState();
}

class _DoublePickerState extends State<DoublePicker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandCardAnimation;

  final int _selectedTimes = 10;
  final int _selectedEffort = 20;

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

  @override
  void didUpdateWidget(covariant DoublePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _expandCardAnimation,
      child: Column(
        children: [
          const Divider(),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    scrollController:
                    FixedExtentScrollController(
                      initialItem: _selectedEffort - 1,
                    ),
                    selectionOverlay: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: FitnessColors.blindGray,
                          ),
                          bottom: BorderSide(
                            color: FitnessColors.blindGray,
                          ),
                        ),
                      ),
                    ),
                    offAxisFraction: -.4,
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {},
                    children: List<Widget>.generate(200, (int index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 64.0),
                          child: Text('${index + 1} kg', style: TextStyle(
                            color: FitnessColors.black,
                          ),),
                        ),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController:
                    FixedExtentScrollController(
                      initialItem: _selectedTimes - 1,
                    ),
                    selectionOverlay: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: FitnessColors.blindGray,
                          ),
                          bottom: BorderSide(
                            color: FitnessColors.blindGray,
                          ),
                        ),
                      ),
                    ),
                    offAxisFraction: .4,
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {},
                    children: List<Widget>.generate(100, (int index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 64.0),
                          child: Text('${index + 1} Reps'),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}