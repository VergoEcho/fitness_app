import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/modal_calendar_bloc/modal_calendar_bloc.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/screens/calendar_training_page.dart';
import 'package:trainings/ui/base_calendar.dart';
import 'package:trainings/widgets/calendar_card.dart';

List<Client> _clients = [
  Client(
    id: 0,
    name: "Alexander",
    phone: "+1234678",
    birthday: "12.08.93",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 80,
  ),
  Client(
    id: 1,
    name: "Dmitriy",
    phone: "+12344278",
    birthday: "30.02.99",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 75,
    clientNote: "want to gain more muscle",
  ),
  Client(
    id: 2,
    name: "Karina",
    phone: "+12300231",
    birthday: "12.11.03",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 42,
    clientNote: "want to lose fat",
  ),
  Client(
    id: 2,
    name: "Diana",
    phone: "+1111231",
    birthday: "03.20.98",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 47,
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: FitnessColors.whiteGray,
      child: SafeArea(
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
                                          BlocBuilder<ModalCalendarBloc,
                                              ModalCalendarState>(
                                            builder: (context, state) {
                                              return BaseCalendar(
                                                onDaySelected:
                                                    (oldDate, newDate) {
                                                  context
                                                      .read<ModalCalendarBloc>()
                                                      .add(
                                                        SelectedDay(
                                                            selectedDay:
                                                                newDate),
                                                      );
                                                },
                                                focusedDay: state.selectedDay,
                                                headerVisible: true,
                                              );
                                            },
                                          ),
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: _activeClients().length,
                                            itemBuilder: (context, index) {
                                              return CalendarCard(
                                                client: _activeClients()[index],
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      CalendarTrainingPage
                                                          .route);
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
                  const BaseCalendar(
                    monthCalendar: false,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _activeClients().length,
              itemBuilder: (BuildContext context, int index) {
                Client client = _activeClients()[index];
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
            ))
          ],
        ),
      ),
    );
  }
}
