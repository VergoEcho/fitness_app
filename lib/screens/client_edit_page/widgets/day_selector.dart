import 'package:flutter/cupertino.dart';
import 'package:trainings/constants/colors.dart';

enum DaySelectorState {unselected, active, selected}

class DaySelector extends StatefulWidget {
  const DaySelector({Key? key, required this.onPressed, required this.day, this.state = DaySelectorState.unselected}) : super(key: key);

  final VoidCallback onPressed;
  final String day;
  final DaySelectorState state;

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {

  Color? _containerColor() {
    switch (widget.state) {
      case DaySelectorState.unselected:
        return null;
      case DaySelectorState.active:
        return FitnessColors.primary;
      case DaySelectorState.selected:
        return FitnessColors.whiteShaded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 36,
          width: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: _containerColor(),
          ),
          child: Text(widget.day.toUpperCase(), style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),),
        ),
        widget.state == DaySelectorState.selected ? Positioned(
          right: -20,
          top: -28,
          child: CupertinoButton(
            onPressed: widget.onPressed,
            child: Icon(CupertinoIcons.minus_circle_fill, color: FitnessColors.red,),
          ),
        ) : const SizedBox(),
      ],
    );
  }
}
