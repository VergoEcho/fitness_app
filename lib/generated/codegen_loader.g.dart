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
  "back": "Back",
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
    "training_notes": "Training notes about something can be that long or shot or"
  },
  "clients_page": {
    "title": "Clients",
    "new_client": "New Client",
    "current": "Current",
    "archive": "Archive"
  },
  "client_edit_page": {
    "title": {
      "edit": "Edit Client",
      "new": "New Client"
    },
    "save": "Save",
    "done": "Done",
    "name": "Name",
    "phone": "Phone Number",
    "birthday": "Birthday",
    "weight": "Weight",
    "goal": "Client Goal",
    "note": "Client Note",
    "select_date_title": "Select days and setup the time",
    "schedule": "Schedule",
    "time": "Time",
    "paid_training": "Paid training"
  },
  "client_profile_page": {
    "title": "Client Profile",
    "edit": "Edit",
    "paid_till": "Paid till",
    "workouts": "workouts",
    "trainings": {
      "title": "Trainings",
      "empty": "The Client doesn’t has any training.\nPlease add from template or create new.",
      "add": "Add training",
      "new_training": "New Training"
    },
    "info": {
      "slider": "Info",
      "weight": "Weight",
      "birthday": "Birthday",
      "training": "Training",
      "goal": "Client Goal",
      "features": "Client Features",
      "phone": "Client Phone",
      "archive": "Move to Archive"
    }
  },
  "new_training_page": {
    "title": "New Training",
    "name": "Training Name",
    "description": "Training description",
    "add": {
      "exercise": "New Exercise",
      "template": "Add from templates",
      "previous": "Add from previous"
    },
    "create": "Create training"
  },
  "trainings_page": {
    "title": "Trainings",
    "new_template": "New Template",
    "templates": "Templates",
    "exercises": "Exercises",
    "search": {
      "templates": "Templates",
      "exercises": "Exercises"
    }
  },
  "exercise_page": {
    "title": "Exercise",
    "edit": "Edit",
    "name": "Exercise Name",
    "description": "Exercise Description",
    "units": {
      "title": "Select Units",
      "weight_reps": "Weight (kg)/Reps (times)",
      "distance_time": "Distance (km)/Time (min)",
      "reps_time": "Reps (times)/Time (min)",
      "custom": "Add custom"
    }
  },
  "template_page": {
    "title": "New Template",
    "name": "Template Name",
    "description": "Template Description",
    "add": {
      "exercise": "Add Exercise",
      "template": "Add from templates",
      "previous": "Add from previous"
    },
    "create": "Create training"
  },
  "search_exercise_page": {
    "title": "Exercises",
    "add": "Add Exercise"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
