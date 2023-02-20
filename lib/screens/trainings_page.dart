import 'package:flutter/cupertino.dart';
import 'package:trainings/widgets/exercise_card.dart';
import 'package:trainings/widgets/training_template_card.dart';

enum TemplateOrExercise { template, exercise }

class TrainingsPage extends StatefulWidget {
  const TrainingsPage({Key? key}) : super(key: key);

  static const String route = '/trainings';

  @override
  State<TrainingsPage> createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingsPage> {
  TemplateOrExercise pageMode = TemplateOrExercise.template;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xfffafafa),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Trainings',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CupertinoButton.filled(
                        borderRadius: BorderRadius.circular(100),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        minSize: 32,
                        onPressed: () {},
                        child: Text(
                          'New Template'.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const CupertinoSearchTextField(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl<TemplateOrExercise>(
                      groupValue: pageMode,
                      children: const <TemplateOrExercise, Widget>{
                        TemplateOrExercise.template: Text('Templates'),
                        TemplateOrExercise.exercise: Text('Exercises'),
                      },
                      onValueChanged: (state) {
                        setState(() {
                          if (pageMode != state) {
                            pageMode = state!;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  if (pageMode == TemplateOrExercise.template) {
                    return const TrainingTemplateCard();
                  } else {
                    return const ExerciseCard();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
