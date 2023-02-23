import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/models/training.dart';

List<Exercise> _exercises = [
  Exercise(
    id: 0,
    title: 'Exercise 1',
    description: '20 kg x 20 Reps',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [
      'Push up • 20 Reps',
      'Push up • 20 Reps',
      'Push up • 20 Reps',
      'Push up • 20 Reps',
    ],
  ),
];

class TrainingTemplateCard extends StatefulWidget {
  const TrainingTemplateCard({Key? key, required this.template}) : super(key: key);

  final Training template;

  @override
  State<TrainingTemplateCard> createState() => _TrainingTemplateCardState();
}

class _TrainingTemplateCardState extends State<TrainingTemplateCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
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
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.template.title),
                    widget.template.description == "" ? const SizedBox() :Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        widget.template.description,
                        style:  TextStyle(fontSize: 14, color: FitnessColors.darkGray),
                      ),
                    ),
                  ],
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
                )
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Timeline.tileBuilder(
                  theme: TimelineThemeData(nodePosition: 0),
                  shrinkWrap: true,
                  builder: TimelineTileBuilder.connected(
                    connectorBuilder: (_, index, __) {
                      return const SolidLineConnector();
                    },
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '${_exercises[0].title} ${_exercises[0].reps[index]}',
                        style: TextStyle(
                          fontSize: 16,
                          color: FitnessColors.blindGray,
                        ),
                      ),
                    ),
                    indicatorBuilder: (_, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: DotIndicator(
                          size: 8,
                        ),
                      );
                    },
                    itemCount: _exercises[0].reps.length,
                  ),
                ),
                // const CustomTimeline(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
