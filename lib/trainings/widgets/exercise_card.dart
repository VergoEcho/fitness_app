import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Exercise name'),
              SizedBox(height: 2),
              Text(
                'Distance (km)/Time (min)',
                style: TextStyle(fontSize: 14, color: Color(0x963c3c43)),
              ),
            ],
          ),
          CupertinoButton(
            onPressed: () {},
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0x963c3c43),
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
