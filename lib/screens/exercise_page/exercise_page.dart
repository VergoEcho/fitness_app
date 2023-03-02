import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainings/common_widgets/field_tile.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';

import 'widget/radio_item.dart';

List<String> units = [
  LocaleKeys.exercise_page_units_weight_reps.tr(),
  LocaleKeys.exercise_page_units_distance_time.tr(),
  LocaleKeys.exercise_page_units_reps_time.tr(),
  LocaleKeys.exercise_page_units_custom.tr(),
];

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  static const String route = '/trainings/exercise';

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: FitnessColors.whiteGray,
      navigationBar: CupertinoNavigationBar(
        border: Border.all(width: 0, color: FitnessColors.white),
        backgroundColor: FitnessColors.white,
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 0),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.chevron_back,
              ),
              Text(LocaleKeys.back.tr())
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text(
          LocaleKeys.exercise_page_title.tr(),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              LocaleKeys.exercise_page_edit.tr(),
            ),
          ),
          onPressed: () {},
        ),
      ),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                color: FitnessColors.white,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24))),
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
            child: Column(
              children: [
                FieldTile(
                  withBorder: true,
                  text: LocaleKeys.exercise_page_name.tr(),
                  controller: _name,
                ),
                FieldTile(
                  withBorder: true,
                  text: LocaleKeys.exercise_page_description.tr(),
                  controller: _description,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
            child: Text(
              LocaleKeys.exercise_page_units_title.tr(),
              style: TextStyle(fontSize: 16, color: FitnessColors.blindGray),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: FitnessColors.white,
            ),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: units.length,
              itemBuilder: (context, index) {
                return RadioItem(
                  index: index,
                  selectedIndex: _selectedIndex,
                  label: units[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
