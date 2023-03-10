import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 16),
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
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.template.title, style: const TextStyle(
                        fontSize: 16,
                      ),),
                      widget.template.description == "" ? const SizedBox() :Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          widget.template.description,
                          style:  TextStyle(fontSize: 14, color: FitnessColors.blindGray),
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
                    child: SvgPicture.asset(
                      'assets/images/chevron-forward.svg',
                      height: 16,
                      width: 16,
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Timeline.tileBuilder(
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
