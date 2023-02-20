import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetCard extends StatefulWidget {
  const SetCard({Key? key, this.editable = false, this.togglePicker}) : super(key: key);

  final bool editable;
  final Function? togglePicker;

  @override
  State<SetCard> createState() => _SetCardState();
}

class _SetCardState extends State<SetCard> {
  late bool editInProgress = true;

  List<Widget> _getSetRows() {
    List<Widget> rows = [];
    for (int i = 0; i < 3; i++) {
      rows.add(const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('20 kg x 20 Reps'),
      ));
    }
    return rows;
  }

  @override
  void initState() {
    editInProgress = widget.editable ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffd9ebff)),
          child: Column(
            children: [
              const SizedBox(height: 8),
              ..._getSetRows(),
              const SizedBox(height: 8),
            ],
          ),
        ),
        Positioned(
          left: 4,
          top: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
                color: CupertinoTheme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              DateFormat('dd.MM.yy').format(DateTime.now()),
              style: const TextStyle(
                color: CupertinoColors.white,
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
                    setState(() {
                      editInProgress = !editInProgress;
                    });
                    widget.togglePicker!();
                  },
                  child: editInProgress
                      ? const Icon(
                          CupertinoIcons.checkmark_alt_circle_fill,
                          color: Color(0xff3ecf8e),
                          size: 32,
                        )
                      : const Icon(
                          CupertinoIcons.add_circled_solid,
                          size: 32,
                        ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
