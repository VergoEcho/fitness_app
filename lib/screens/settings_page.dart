import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainings/bloc/settings_cubit/settings_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/screens/exercise_page/widget/radio_item.dart';
import 'package:trainings/screens/offer_page.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  static const String route = '/settings';

  final Map<FirstWeekday, String> weekdayText = {
    FirstWeekday.monday: LocaleKeys.settings_page_first_weekday_monday.tr(),
    FirstWeekday.sunday: LocaleKeys.settings_page_first_weekday_sunday.tr(),
  };

  final Map<TimeFormat, String> timeFormatText = {
    TimeFormat.twelve: LocaleKeys.settings_page_time_format_12.tr(),
    TimeFormat.twentyFour: LocaleKeys.settings_page_time_format_24.tr(),
  };

  final Map<TimeFormat, String> unitsText = {
    TimeFormat.twelve: LocaleKeys.settings_page_units_metric.tr(),
    TimeFormat.twentyFour: LocaleKeys.settings_page_units_imperial.tr(),
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: FitnessColors.whiteGray,
      navigationBar: CupertinoNavigationBar(
        border: Border.all(width: 0, color: FitnessColors.white),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 0),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.chevron_back,
              ),
              Text(LocaleKeys.back.tr())
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text(
          LocaleKeys.settings_page_title.tr(),
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    top: 16,
                  ),
                  child: Text(
                    LocaleKeys.settings_page_first_weekday_title
                        .tr()
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: FitnessColors.blindGray,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 16, left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: FitnessColors.white,
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: weekdayText.length,
                    itemBuilder: (context, index) {
                      return RadioItem(
                        onTap: () {
                          context.read<SettingsCubit>().update(state.copyWith(
                                weekday: FirstWeekday.values[index],
                              ));
                        },
                        index: index,
                        selectedIndex: state.weekday.index,
                        label: weekdayText.values.toList()[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: FitnessColors.blindGray,
                        height: 1,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    top: 16,
                  ),
                  child: Text(
                    LocaleKeys.settings_page_first_weekday_title
                        .tr()
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: FitnessColors.blindGray,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 16, left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: FitnessColors.white,
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: timeFormatText.length,
                    itemBuilder: (context, index) {
                      return RadioItem(
                        onTap: () {
                          context.read<SettingsCubit>().update(state.copyWith(
                                timeFormat: TimeFormat.values[index],
                              ));
                        },
                        index: index,
                        selectedIndex: state.timeFormat.index,
                        label: timeFormatText.values.toList()[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: FitnessColors.blindGray,
                        height: 1,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    top: 16,
                  ),
                  child: Text(
                    LocaleKeys.settings_page_first_weekday_title
                        .tr()
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: FitnessColors.blindGray,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 16, left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: FitnessColors.white,
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: unitsText.length,
                    itemBuilder: (context, index) {
                      return RadioItem(
                        onTap: () {
                          context.read<SettingsCubit>().update(state.copyWith(
                                units: Units.values[index],
                              ));
                        },
                        index: index,
                        selectedIndex: state.units.index,
                        label: unitsText.values.toList()[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: FitnessColors.blindGray,
                        height: 1,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    top: 16,
                  ),
                  child: Text(
                    LocaleKeys.settings_page_support_title.tr().toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: FitnessColors.blindGray,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.of(context, rootNavigator: true)
                      .pushNamed(OfferPage.route),
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, right: 16, left: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: FitnessColors.white,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: FitnessColors.orange,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/unlock.svg',
                            height: 16,
                            width: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            LocaleKeys.settings_page_support_text.tr(),
                            style: TextStyle(
                              color: FitnessColors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    top: 16,
                  ),
                  child: Text(
                    LocaleKeys.settings_page_help_title.tr().toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: FitnessColors.blindGray,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 16, left: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: FitnessColors.white,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: FitnessColors.violet,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/feedback.svg',
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  LocaleKeys.settings_page_help_feedback.tr(),
                                  style: TextStyle(
                                    color: FitnessColors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: FitnessColors.primary,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/terms.svg',
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  LocaleKeys.settings_page_help_terms.tr(),
                                  style: TextStyle(
                                    color: FitnessColors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
