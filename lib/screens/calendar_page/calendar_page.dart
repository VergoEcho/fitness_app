import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/calendar_page_cubit/calendar_page_cubit.dart';
import 'package:trainings/bloc/clients_cubit/clients_cubit.dart';
import 'package:trainings/bloc/selected_training_cubit/selected_training_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/screens/calendar_training_page/calendar_training_page.dart';
import 'package:trainings/common_widgets/base_calendar.dart';
import 'package:trainings/screens/calendar_page/widgets/calendar_card.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  static const String route = '/calendar';

  List<Client> _selectedClients(BuildContext context, DateTime selectedDay) {
    List<Client> clients = context.read<ClientsCubit>().state.clients;

    return clients
        .where((client) {
          return client.isArchive == false;
        })
        .where(
          (client) => client.trainingDays.entries.any(
            (element) =>
                (element.key ==
                    DateFormat('EEEE', context.locale.languageCode)
                        .format(selectedDay)
                        .toLowerCase()) &&
                element.value != null,
          ),
        )
        .toList();
  }

  Widget _cardBuilder(BuildContext context, int index) {
    CalendarPageState state = context.read<CalendarPageCubit>().state;
    Client client = _selectedClients(context, state.selectedDay)[index];
    return CalendarCard(
      client: client,
      onTap: () {
        context
            .read<SelectedTrainingCubit>()
            .select(selectedDay: state.selectedDay, client: client);
        Navigator.of(context, rootNavigator: true)
            .pushNamed(
              CalendarTrainingPage.route,
            )
            .then(
              (value) => Future.delayed(
                const Duration(milliseconds: 500),
                () => context.read<SelectedTrainingCubit>().clear(),
              ),
            );
      },
    );
  }

  showModal(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      // backgroundColor: const Color(0xfffafafa),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: .7,
          expand: false,
          builder: (context, controller) {
            return ListView(
              controller: controller,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.calendar_page_modalTitle.tr(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: CircleAvatar(
                          maxRadius: 15,
                          backgroundColor: FitnessColors.whiteShaded,
                          child: Icon(
                            Icons.close,
                            weight: 200,
                            size: 16,
                            color: FitnessColors.darkGray,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                BlocBuilder<CalendarPageCubit, CalendarPageState>(
                  builder: (context, state) {
                    return BaseCalendar(
                      onDaySelected: (newDate, oldDate) =>
                          context.read<CalendarPageCubit>().selectDate(newDate),
                      focusedDay: state.selectedDay,
                      headerVisible: true,
                      eventLoader: (date) => _selectedClients(context, date),
                    );
                  },
                ),
                BlocBuilder<CalendarPageCubit, CalendarPageState>(
                  builder: (context, state) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          _selectedClients(context, state.selectedDay).length,
                      itemBuilder: _cardBuilder,
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FitnessColors.whiteGray,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
              decoration: BoxDecoration(
                color: FitnessColors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.calendar_page_title.tr(),
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.only(left: 16, right: 0),
                        onPressed: () => showModal(context),
                        child: Row(
                          children: [
                            BlocBuilder<CalendarPageCubit, CalendarPageState>(
                              builder: (context, state) {
                                return Text(
                                  DateFormat('MMMM, yyyy',
                                          context.locale.languageCode)
                                      .format(state.selectedDay),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    letterSpacing: -0.41,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(Icons.calendar_month_outlined)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<CalendarPageCubit, CalendarPageState>(
                    builder: (context, state) {
                      return BaseCalendar(
                        monthCalendar: false,
                        focusedDay: state.selectedDay,
                        onDaySelected: (newDate, oldDate) {
                          context.read<CalendarPageCubit>().selectDate(newDate);
                        },
                        eventLoader: (date) {
                          return _selectedClients(context, date);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<CalendarPageCubit, CalendarPageState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount:
                        _selectedClients(context, state.selectedDay).length,
                    itemBuilder: _cardBuilder,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
