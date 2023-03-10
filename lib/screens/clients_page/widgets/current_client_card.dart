import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainings/bloc/selected_client_cubit/selected_client_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/screens/client_profile_page/client_profile_page.dart';
import 'package:trainings/common_widgets/base_calendar.dart';

class CurrentClientCard extends StatelessWidget {
  const CurrentClientCard({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;

  // String _time(TimeOfDay startTime, BuildContext context) {
  //   return '${startTime.format(context)} - ${startTime.replacing(hour: startTime.hour + 1).format(context)}';
  // }

  _onClientTapped(BuildContext context) {
    context.read<SelectedClientCubit>().select(client);
    Navigator.of(context, rootNavigator: true)
        .pushNamed(ClientProfilePage.route)
        .then(
          (value) {
        Future.delayed(const Duration(milliseconds: 500),
                () => context.read<SelectedClientCubit>().clear());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _onClientTapped(context),
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: FitnessColors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${LocaleKeys.client_profile_page_paid_till.tr()}: ${DateFormat('dd MMM yyy').format(DateTime.now()).toString()} (${client.paidTrainings} ${LocaleKeys.client_profile_page_workouts.tr()})',
                          style: TextStyle(
                              fontSize: 16, color: FitnessColors.blindGray),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text('10:00-10:45', style: TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                    ],
                  ),
                  CupertinoButton(
                    onPressed: null,
                    child: SvgPicture.asset(
                      'assets/images/chevron-forward.svg',
                      height: 16,
                      width: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(),
            const BaseCalendar(
              oneLetter: true,
              monthCalendar: false,
            ),
          ],
        ),
      ),
    );
  }
}
