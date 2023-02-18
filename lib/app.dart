import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainings/home.dart';

import 'calendar/calendar.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return CupertinoApp(
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      title: 'Training app',
      // theme: appTheme,
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (context) => const HomePage(),
        CalendarTrainingPage.route: (context) => const CalendarTrainingPage(),
      },
    );
  }
}
