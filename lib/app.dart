import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainings/bloc/calendar_page_cubit/calendar_page_cubit.dart';
import 'package:trainings/bloc/client_edit_cubit/client_edit_cubit.dart';
import 'package:trainings/bloc/client_profile_page_bloc/client_profile_page_bloc.dart';
import 'package:trainings/bloc/clients_cubit/clients_cubit.dart';
import 'package:trainings/bloc/clients_page_bloc/clients_page_bloc.dart';
import 'package:trainings/bloc/exercise_edit_cubit/exercise_edit_cubit.dart';
import 'package:trainings/bloc/exercises_cubit/exercises_cubit.dart';
import 'package:trainings/bloc/modal_calendar_cubit/modal_calendar_cubit.dart';
import 'package:trainings/bloc/new_training_cubit/new_training_cubit.dart';
import 'package:trainings/bloc/search_cubit/search_cubit.dart';
import 'package:trainings/bloc/selected_client_cubit/selected_client_cubit.dart';
import 'package:trainings/bloc/selected_exercise_cubit/selected_exercise_cubit.dart';
import 'package:trainings/bloc/selected_training_cubit/selected_training_cubit.dart';
import 'package:trainings/bloc/settings_cubit/settings_cubit.dart';
import 'package:trainings/bloc/trainings_cubit/trainings_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/screens/calendar_page/calendar_page.dart';
import 'package:trainings/screens/client_edit_page/client_edit_page.dart';
import 'package:trainings/screens/client_profile_page/client_profile_page.dart';
import 'package:trainings/screens/clients_page/clients_page.dart';
import 'package:trainings/screens/exercise_page/exercise_page.dart';
import 'package:trainings/screens/exercise_search_page/exercises_search_page.dart';
import 'package:trainings/screens/new_training_page/new_training_page.dart';
import 'package:trainings/screens/offer_page.dart';
import 'package:trainings/screens/settings_page.dart';
import 'package:trainings/screens/trainings_page/trainings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/screens/trainings_search.dart';

import 'bloc/trainings_page_bloc/training_page_bloc.dart';
import 'screens/calendar_training_page/calendar_training_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const tabPages = [CalendarPage(), TrainingsPage(), ClientsPage()];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TrainingPageBloc()),
        BlocProvider(create: (context) => ClientsPageBloc()),
        BlocProvider(create: (context) => ClientProfilePageBloc()),
        BlocProvider(create: (context) => ModalCalendarCubit()),
        BlocProvider(create: (context) => ModalCalendarCubit()),
        BlocProvider(create: (context) => CalendarPageCubit()),
        BlocProvider(create: (context) => SelectedClientCubit()),
        BlocProvider(create: (context) => ClientsCubit()..fetchClients()),
        BlocProvider(create: (context) => SelectedTrainingCubit()),
        BlocProvider(create: (context) => ExercisesCubit()..fetchExercises()),
        BlocProvider(create: (context) => SelectedExerciseCubit()),
        BlocProvider(create: (context) => ClientEditCubit()),
        BlocProvider(create: (context) => NewTrainingCubit()),
        BlocProvider(create: (context) => ExerciseEditCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => TrainingsCubit()..fetchTrainings()),
        BlocProvider(create: (context) => SettingsCubit()),
      ],
      child: CupertinoApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: LocaleKeys.app_title.tr(),
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: FitnessColors.primary,
        ),
        routes: {
          CalendarPage.route: (context) => const CalendarPage(),
          TrainingsPage.route: (context) => const TrainingsPage(),
          ClientsPage.route: (context) => const ClientsPage(),
          CalendarTrainingPage.route: (context) => const CalendarTrainingPage(),
          ClientProfilePage.route: (context) => const ClientProfilePage(),
          ClientEditPage.route: (context) => const ClientEditPage(),
          ExercisePage.route: (context) => const ExercisePage(),
          NewTrainingPage.route: (context) => const NewTrainingPage(),
          ExercisesSearchPage.route: (context) => const ExercisesSearchPage(),
          TrainingsSearchPage.route: (context) => const TrainingsSearchPage(),
          SettingsPage.route: (context) => SettingsPage(),
          OfferPage.route: (context)=> const OfferPage(),
        },
        home: Builder(
            builder: (context) {
              return CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  height: 56,
                  backgroundColor: FitnessColors.white,
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.calendar_month),
                      label: LocaleKeys.tab_bar_calendar.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.fitness_center),
                      label: LocaleKeys.tab_bar_training.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.people),
                      label: LocaleKeys.tab_bar_clients.tr(),
                    ),
                  ],
                ),
                tabBuilder: (BuildContext context, int index) {
                  return CupertinoTabView(
                    builder: (context) => tabPages[index],
                  );
                },
              );
            }
        ),
      ),
    );
  }
}
