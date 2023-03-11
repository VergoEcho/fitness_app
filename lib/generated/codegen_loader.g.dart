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
    "training_notes": "Training notes about something can be that long or shot or",
    "today": "Today"
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
    "error": {
      "name": {
        "title": "Error",
        "description": "User name is empty",
        "confirm": "Confirm",
        "field": "Name cannot be blank"
      }
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
    "error": {
      "title": "Error",
      "name": {
        "description": "Training name is empty",
        "field": "Training name cannot be blank",
        "confirm": "Confirm"
      }
    },
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
      "exercises": "Exercises",
      "cancel": "Cancel"
    }
  },
  "exercise_page": {
    "title": {
      "edit": "Exercise",
      "new": "New Exercise"
    },
    "edit": "Edit",
    "save": "Save Exercise",
    "name": "Exercise Name",
    "description": "Exercise Description",
    "error": {
      "title": "Error",
      "name": {
        "description": "Exercise name is empty",
        "field": "Exercise name cannot be blank",
        "confirm": "Confirm"
      }
    },
    "units": {
      "title": "Select Units",
      "weight_reps": "Weight (kg)/Reps (times)",
      "distance_time": "Distance (km)/Time (min)",
      "reps_time": "Reps (times)/Time (min)",
      "custom": "Add custom"
    }
  },
  "new_template_page": {
    "error": {
      "title": "Error",
      "name": {
        "description": "Template name is empty",
        "field": "Template name cannot be blank",
        "confirm": "Confirm"
      }
    },
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
    "add": "Add Exercise",
    "new_exercise": "New Exercise",
    "no_exercise_label": "Looks like there is no exercise you are looking for. Create a new one?"
  },
  "offer_page": {
    "title": "Unlock",
    "subtitle": "Trainer's Board for PRO",
    "features": {
      "title": "Unlock unlimited feature with PRO Account:",
      "unlimited_templates": "Add UNLIMITED training templates",
      "archive_clients": "Move your clients to the archive",
      "unlimited_clients": "Add UNLIMITED clients"
    },
    "subscribe": "Subscribe for 4,99 USD / Month",
    "cancel": "Continue using for Free"
  },
  "settings_page": {
    "title": "Settings",
    "first_weekday": {
      "title": "First weekday",
      "monday": "Monday",
      "sunday": "Sunday"
    },
    "time_format": {
      "title": "Time format",
      "12": "12-hours",
      "24": "24-hours"
    },
    "units": {
      "title": "Units",
      "metric": "Metric systems (kg, cm, km)",
      "imperial": "Imperial systems (lb, in, ml)"
    },
    "support": {
      "title": "Support",
      "text": "Unlock PRO version"
    },
    "help": {
      "title": "Help",
      "feedback": "Send Feedback",
      "terms": "Terms and Privacy"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
