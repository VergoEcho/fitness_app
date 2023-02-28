import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/selected_client_cubit/selected_client_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/screens/client_profile_page/client_profile_page.dart';
import 'package:trainings/common_widgets/base_calendar.dart';

class CurrentClientCard extends StatelessWidget {
  const CurrentClientCard({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.read<SelectedClientCubit>().select(client);
        Navigator.of(context, rootNavigator: true)
          .pushNamed(ClientProfilePage.route);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FitnessColors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(client.name, style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),),
                    client.clientNote == ""
                        ? const SizedBox()
                        : Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                              client.clientNote,
                              style: TextStyle(
                                  fontSize: 14, color: FitnessColors.darkGray),
                            ),
                        ),
                    const Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Text('10:00-10:45'),
                    ),
                  ],
                ),
                CupertinoButton(
                  onPressed: null,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: FitnessColors.darkGray,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(),
            const BaseCalendar(
              monthCalendar: false,
            ),
          ],
        ),
      ),
    );
  }
}
