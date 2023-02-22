// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "app_title": "Fitness App",
  "days": {
    "monday": "Mon",
    "tuesday": "Tue",
    "wednesday": "Wed",
    "thursday": "Thu",
    "friday": "Fri",
    "saturday": "Sat",
    "sunday": "Sun"
  },
  "tab_bar": {
    "calendar": "Calendar",
    "training": "Training",
    "clients": "Clients"
  },
  "calendar_page": {
    "title": "Today",
    "modalTitle": "Calendar"
  },
  "calendar_training_page": {
    "back": "Back",
    "new_exercise": "New Exercise",
    "client_name": "Client Name",
    "training_name": "Training Name",
    "training_notes": "Traning notes about something can be that long or shot or"
  },
  "clients_page": {
    "title": "Clients",
    "new_client": "New Client",
    "current": "Current",
    "archive": "Archive"
  },
  "client_profile_page": {
    "title": "Client Profile",
    "back": "Back",
    "edit": "Edit",
    "paid_till": "Paid till",
    "workouts": "workouts",
    "trainings": "Trainings",
    "info": "Info",
    "new_template": "New Template"
  },
  "trainings_page": {
    "title": "Trainings",
    "new_template": "New Template",
    "templates": "Templates",
    "exercises": "Exercises"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
