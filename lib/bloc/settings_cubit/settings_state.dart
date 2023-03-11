part of 'settings_cubit.dart';

enum FirstWeekday { monday, sunday }

enum TimeFormat { twentyFour, twelve }

enum Units { metric, imperial }

class SettingsState {
  final FirstWeekday weekday;
  final TimeFormat timeFormat;
  final Units units;

  SettingsState({
    this.weekday = FirstWeekday.monday,
    this.timeFormat = TimeFormat.twentyFour,
    this.units = Units.metric,
  });

  SettingsState copyWith({
    FirstWeekday? weekday,
    TimeFormat? timeFormat,
    Units? units,
  }) {
    return SettingsState(
      weekday: weekday ?? this.weekday,
      timeFormat: timeFormat ?? this.timeFormat,
      units: units ?? this.units,
    );
  }
}
