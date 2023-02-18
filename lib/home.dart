import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/calendar/calendar.dart';
import 'package:trainings/clients/clients.dart';
import 'package:trainings/trainings/trainings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clients'),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return const CalendarPage();
          case 1:
            return const TrainingsPage();
          case 2:
            return const ClientsPage();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
