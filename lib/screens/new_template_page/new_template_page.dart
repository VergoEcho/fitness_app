import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/common_widgets/field_tile.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/exercise.dart';
import 'package:trainings/models/template.dart';
import 'package:trainings/screens/trainings_page/widgets/exercise_card.dart';

import 'widgets/template_card.dart';

List<Template> _templates = [
  Template(
    id: 0,
    title: 'Template Name',
    description: 'Description here',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Template(
    id: 1,
    title: 'Template Name',
    description: 'Description here',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Template(
    id: 2,
    title: 'Template Name',
    description: 'Description here',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

List<Exercise> _exercises = [
  Exercise(
    id: 0,
    title: 'Exercise Name',
    description: 'Distance (km)/Time (min)',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [],
  ),
  Exercise(
    id: 1,
    title: 'Exercise Name',
    description: 'Distance (km)/Time (min)',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    reps: const [],
  ),
];

class NewTemplatePage extends StatelessWidget {
  NewTemplatePage({Key? key}) : super(key: key);

  static const String route = '/trainings/new_template';

  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();

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
          LocaleKeys.template_page_title.tr(),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    text: LocaleKeys.template_page_name.tr(),
                    controller: _name,
                  ),
                  FieldTile(
                    withBorder: true,
                    text: LocaleKeys.template_page_description.tr(),
                    controller: _description,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: FitnessColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.template_page_add_exercise.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                        CupertinoButton(
                          onPressed: () {},
                          child: const Icon(CupertinoIcons.add_circled_solid),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.template_page_add_template.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: FitnessColors.blindGray,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 76,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _templates.length,
                      itemBuilder: (context, index) {
                        return TemplateCard(
                          fixedWidth: 240,
                          template: _templates[index],
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.template_page_add_previous.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: FitnessColors.blindGray,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 76,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _exercises.length,
                      itemBuilder: (context, index) {
                        return ExerciseCard(
                          marginTopDisabled: true,
                          fixedWidth: 240,
                          onTap: () {},
                          exercise: _exercises[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: Text(
                  LocaleKeys.template_page_create.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
