import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:trainings/models/training.dart';

List<String> exercises = [
  '20 kg x 20 Reps',
  '20 kg x 20 Reps',
  '20 kg x 20 Reps',
  '20 kg x 20 Reps',
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
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          GestureDetector(
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
                    widget.template.description == "" ? SizedBox() :Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        widget.template.description,
                        style: const TextStyle(fontSize: 14, color: Color(0x963c3c43)),
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
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0x963c3c43),
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
                        exercises[index],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff828282),
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
                    itemCount: exercises.length,
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
