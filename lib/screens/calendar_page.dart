import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/calendar_page_cubit/calendar_page_cubit.dart';
import 'package:trainings/bloc/modal_calendar_cubit/modal_calendar_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/screens/calendar_training_page.dart';
import 'package:trainings/ui/base_calendar.dart';
import 'package:trainings/widgets/calendar_card.dart';

List<Client> _clients = [
  Client(
    id: 0,
    name: "Contact Name",
    clientNote: "Comment About",
    phone: "+1234678",
    birthday: "12.08.93",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    trainingDays: const [
      "monday",
      "wednesday",
      "thursday",
    ],
    weight: 80,
  ),
  Client(
    id: 1,
    name: "Contact Name",
    clientNote: "Comment About",
    phone: "+12344278",
    birthday: "30.02.99",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    trainingDays: const [
      "monday",
      "wednesday",
      "friday",
    ],
    weight: 75,
  ),
  Client(
    id: 2,
    name: "Contact Name",
    phone: "+12300231",
    birthday: "12.11.03",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 42,
    trainingDays: const [
      "monday",
      "wednesday",
      "friday",
    ],
    clientNote: "Comment About",
  ),
  Client(
    id: 2,
    name: "Contact Name",
    clientNote: "Comment About",
    phone: "+1111231",
    birthday: "03.20.98",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 47,
    trainingDays: const [
      "monday",
      "friday",
    ],
    isArchive: true,
  ),
];

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  static const String route = '/calendar';

  List<Client> _activeClients() {
    return _clients.where((client) {
      return client.isArchive == false;
    }).toList();
  }

  List<Client> _selectedClients(BuildContext context, state) {
    return _activeClients()
        .where(
          (client) => client.trainingDays.any((element) =>
              element ==
              DateFormat('EEEE', context.locale.languageCode)
                  .format(state.selectedDay)
                  .toLowerCase()),
        )
        .toList();
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
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
                                            padding: const EdgeInsets.only(
                                                left: 16, top: 8, bottom: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  LocaleKeys
                                                      .calendar_page_modalTitle
                                                      .tr(),
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: Icon(
                                                    Icons.cancel,
                                                    size: 32,
                                                    color:
                                                        FitnessColors.darkGray,
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Divider(),
                                          BlocBuilder<ModalCalendarCubit,
                                              ModalCalendarState>(
                                            builder: (context, state) {
                                              return BaseCalendar(
                                                onDaySelected:
                                                    (newDate, oldDate) {
                                                  context
                                                      .read<
                                                          ModalCalendarCubit>()
                                                      .selectDate(newDate);
                                                },
                                                focusedDay: state.selectedDay,
                                                headerVisible: true,
                                              );
                                            },
                                          ),
                                          BlocBuilder<ModalCalendarCubit,
                                              ModalCalendarState>(
                                            builder: (context, state) {
                                              return ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: _selectedClients(
                                                        context, state)
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return CalendarCard(
                                                    client: _selectedClients(
                                                        context, state)[index],
                                                    onTap: () {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pushNamed(
                                                              CalendarTrainingPage
                                                                  .route);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          )
                                        ],
                                      );
                                    });
                              });
                        },
                        child: Row(
                          children: [
                            Text(DateFormat(
                                    'MMMM, yyyy', context.locale.languageCode)
                                .format(DateTime.now())),
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
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(child: BlocBuilder<CalendarPageCubit, CalendarPageState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: _selectedClients(context, state).length,
                  itemBuilder: (BuildContext context, int index) {
                    Client client = _selectedClients(context, state)[index];
                    return CalendarCard(
                      client: client,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          CalendarTrainingPage.route,
                          arguments: {"client": client},
                        );
                      },
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

