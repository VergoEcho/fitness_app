import 'package:flutter/cupertino.dart';

class DayCard extends StatelessWidget {
  const DayCard({
    Key? key,
    required this.day,
    this.time,
  }) : super(key: key);

  final String? time;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: time != null ? CupertinoTheme.of(context).primaryColor : null,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            day.toUpperCase(),
            style: TextStyle(
                color: time != null
                    ? CupertinoColors.white
                    : const Color(0xaa3c3c43),
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
          time != null
              ? Text(
            time!,
            style: const TextStyle(
              color: Color(0x99ffffff),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}
