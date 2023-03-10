import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/new_training_cubit/new_training_cubit.dart';
import 'package:trainings/bloc/trainings_cubit/trainings_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/common_widgets/filled_button.dart';
import 'package:trainings/screens/client_profile_page/widgets/client_training_tile.dart';
import 'package:trainings/screens/new_training_page/new_training_page.dart';

class ClientTrainings extends StatelessWidget {
  const ClientTrainings({Key? key}) : super(key: key);

  _createNewTraining(BuildContext context) {
    context.read<NewTrainingCubit>().changeMode(
        NewTrainingMode());
    Navigator.of(context, rootNavigator: true)
        .pushNamed(NewTrainingPage.route);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingsCubit, TrainingsState>(
        builder: (context, state) {
          return state.trainings.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.client_profile_page_trainings_empty.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: FitnessColors.blindGray,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 16,
                  ),
                ),
                onPressed: _createNewTraining(context),
                child: Text(
                  LocaleKeys.client_profile_page_trainings_add.tr(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 160)
            ],
          )
              : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${LocaleKeys.client_profile_page_trainings_title
                          .tr()} (${state.trainings.length})',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    AppleFilledButton(
                      text: LocaleKeys
                          .client_profile_page_trainings_new_training
                          .tr()
                          .toUpperCase(),
                      onPressed: () => _createNewTraining(context),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.trainings.length,
                itemBuilder: (context, index) {
                  return ClientTrainingTile(
                    onTap: () {},
                    training: state.trainings[index],
                  );
                },
              )
            ],
          );
        });
  }
}
