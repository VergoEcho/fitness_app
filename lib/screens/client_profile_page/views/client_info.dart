import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/selected_client_cubit/selected_client_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';

import '../widgets/client_info_badge.dart';
import '../widgets/client_info_tile.dart';

class ClientInfo extends StatelessWidget {
  const ClientInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedClientCubit, SelectedClientState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Row(
                  children: [
                    ClientInfoBadge(
                        value: state.client!.weight.floor().toString(),
                        label:
                            LocaleKeys.client_profile_page_info_weight.tr(),
                        color: FitnessColors.green),
                    const SizedBox(width: 8),
                    ClientInfoBadge(
                      value: state.client!.birthday,
                      label:
                          LocaleKeys.client_profile_page_info_birthday.tr(),
                      color: FitnessColors.violet,
                    ),
                    const SizedBox(width: 8),
                    ClientInfoBadge(
                      value: state.client!.payedTrainings.toString(),
                      label:
                          LocaleKeys.client_profile_page_info_training.tr(),
                      color: FitnessColors.orange,
                    ),
                  ],
                ),
              ),
              ClientInfoTile(
                label: LocaleKeys.client_profile_page_info_goal.tr(),
                text: state.client!.clientGoal,
              ),
              ClientInfoTile(
                label: LocaleKeys.client_profile_page_info_features.tr(),
                text: state.client!.clientNote,
              ),
              ClientInfoTile(
                label: LocaleKeys.client_profile_page_info_phone.tr(),
                text: state.client!.phone,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: FitnessColors.whiteShaded,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13), // <-- Radius
                    ),
                  ),
                  child: Text(
                    LocaleKeys.client_profile_page_info_archive.tr(),
                    style: TextStyle(
                      color: FitnessColors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
