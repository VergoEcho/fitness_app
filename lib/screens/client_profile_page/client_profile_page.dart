import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/client_edit_cubit/client_edit_cubit.dart';
import 'package:trainings/bloc/client_profile_page_bloc/client_profile_page_bloc.dart';
import 'package:trainings/bloc/selected_client_cubit/selected_client_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/screens/client_edit_page/client_edit_page.dart';
import 'package:trainings/screens/client_profile_page/views/client_info.dart';
import 'package:trainings/screens/client_profile_page/widgets/day_card.dart';

import 'views/client_trainings.dart';

class ClientProfilePage extends StatelessWidget {
  const ClientProfilePage({Key? key}) : super(key: key);

  static const route = '/client/profile';

  void _editClient(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(ClientEditPage.route)
        .then(
          (_) => Future.delayed(
            const Duration(milliseconds: 500),
            () => context.read<ClientEditCubit>().clear(),
          ),
        );
  }

  String _paidTill(BuildContext context) {
    SelectedClientState state = context.read<SelectedClientCubit>().state;
    return '${LocaleKeys.client_profile_page_paid_till.tr()}: ${DateFormat('dd MMM yyy').format(DateTime.now()).toString()} (${state.client!.paidTrainings} ${LocaleKeys.client_profile_page_workouts.tr()})';
  }

  String? _dayTime(MapEntry<String, TimeOfDay?> day) {
    return day.value == null
        ? null
        : '${day.value!.hour.toString().padLeft(2, '0')}:${day.value!.minute.toString().padLeft(2, '0')}';
  }

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
              const SizedBox(width: 4),
              Text(LocaleKeys.back.tr())
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(LocaleKeys.client_profile_page_title.tr()),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              LocaleKeys.client_profile_page_edit.tr(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          onPressed: () => _editClient(context),
        ),
      ),
      child: BlocBuilder<ClientProfilePageBloc, TrainingsOrInfo>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                decoration: BoxDecoration(
                  color: FitnessColors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    BlocBuilder<SelectedClientCubit, SelectedClientState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.client!.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  _paidTill(context),
                                  style:
                                      TextStyle(color: FitnessColors.blindGray),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: state.client!.trainingDays.entries
                                    .map((day) {
                                  return DayCard(
                                      day: day.key.substring(0, 3),
                                      time: _dayTime(day));
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl<TrainingsOrInfo>(
                        thumbColor: FitnessColors.white,
                        groupValue: state,
                        children: <TrainingsOrInfo, Widget>{
                          TrainingsOrInfo.trainings: Text(LocaleKeys
                              .client_profile_page_trainings_title
                              .tr()),
                          TrainingsOrInfo.info: Text(
                              LocaleKeys.client_profile_page_info_slider.tr()),
                        },
                        onValueChanged: (value) {
                          context
                              .read<ClientProfilePageBloc>()
                              .add(ClientProfilePageModeChanged(value!));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: state == TrainingsOrInfo.trainings
                      ? const ClientTrainings()
                      : const ClientInfo(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
