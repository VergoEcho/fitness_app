import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/screens/calendar_training_page.dart';
import 'package:trainings/ui/base_calendar.dart';
import 'package:trainings/widgets/calendar_card.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  static const String route = '/calendar';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xfffafafa),
      child: SafeArea(
        child: Column(
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
                      Text(
                        LocaleKeys.calendar_page_title.tr(),
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, right: 0, bottom: 16),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                LocaleKeys.calendar_page_modalTitle.tr(),
                                                style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              CupertinoButton(
                                                child: const Icon(Icons.cancel, size: 32, color: Color(0xff65656b),),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                        const BaseCalendar(
                                          headerVisible: true,
                                        ),
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 6,
                                          itemBuilder: (context, index) {
                                            return CalendarCard(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    CalendarTrainingPage.route);
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        )
                                      ],
                                    );
                                  }
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Text(DateFormat('MMMM, yyyy', context.locale.languageCode)
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
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return CalendarCard(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(CalendarTrainingPage.route);
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