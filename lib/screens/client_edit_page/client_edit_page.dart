import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/client_edit_cubit/client_edit_cubit.dart';
import 'package:trainings/bloc/selected_client_cubit/selected_client_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/common_widgets/field_tile.dart';

import 'widgets/day_selector.dart';

class ClientEditPage extends StatefulWidget {
  const ClientEditPage({Key? key}) : super(key: key);

  static const String route = 'client/edit';

  @override
  State<ClientEditPage> createState() => _ClientEditPageState();
}

class _ClientEditPageState extends State<ClientEditPage>
    with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  late DateTime _birthday;
  bool _birthdayExpanded = false;
  late final AnimationController _birthdayExpandController;
  late final Animation<double> _birthdayExpandAnimation;
  late int _weight;
  bool _weightExpanded = false;
  late final AnimationController _weightExpandController;
  late final Animation<double> _weightExpandAnimation;
  late int _paidTrainings;
  bool _paidTrainingsExpanded = false;
  late final AnimationController _paidExpandController;
  late final Animation<double> _paidExpandAnimation;
  String? editDay;
  late TimeOfDay _selectedTime;

  // void _initControllers () async {
  //   await _nameController.value = _nameController.value.copyWith(text: )
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _goalController.dispose();
    _noteController.dispose();

    _birthdayExpandController.dispose();
    _weightExpandController.dispose();
    _paidExpandController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _birthday = DateTime.now();
    _weight = 70;
    _paidTrainings = 0;
    _selectedTime = const TimeOfDay(hour: 12, minute: 00);

    _birthdayExpandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _birthdayExpandAnimation = CurvedAnimation(
      parent: _birthdayExpandController,
      curve: Curves.fastOutSlowIn,
    );

    _weightExpandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _weightExpandAnimation = CurvedAnimation(
      parent: _weightExpandController,
      curve: Curves.fastOutSlowIn,
    );

    _paidExpandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _paidExpandAnimation = CurvedAnimation(
      parent: _paidExpandController,
      curve: Curves.fastOutSlowIn,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool clientIsNew =
        context.read<SelectedClientCubit>().state is SelectedClientNone;

    return BlocBuilder<ClientEditCubit, ClientEditState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          backgroundColor: FitnessColors.whiteGray,
          navigationBar: CupertinoNavigationBar(
            border: Border.all(width: 0, color: FitnessColors.white),
            backgroundColor: FitnessColors.whiteGray,
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 4, vertical: 0),
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
              clientIsNew is SelectedClientNone
                  ? LocaleKeys.client_edit_page_title_new.tr()
                  : LocaleKeys.client_edit_page_title_edit.tr(),
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  clientIsNew
                      ? LocaleKeys.client_edit_page_save.tr()
                      : LocaleKeys.client_edit_page_done.tr(),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                FieldTile(
                  controller: _nameController..text = clientIsNew
                      ? ''
                      : context
                      .read<SelectedClientCubit>()
                      .state
                      .client!
                      .phone,
                  text: LocaleKeys.client_edit_page_name.tr(),
                ),
                FieldTile(
                  controller: _phoneController
                    ..text = clientIsNew
                        ? ''
                        : context
                            .read<SelectedClientCubit>()
                            .state
                            .client!
                            .phone,
                  text: LocaleKeys.client_edit_page_phone.tr(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: FitnessColors.white,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _birthdayExpanded = !_birthdayExpanded;
                          });
                          if (_birthdayExpanded) {
                            _birthdayExpandController.forward();
                          } else {
                            _birthdayExpandController.reverse();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.client_edit_page_birthday.tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    DateFormat('dd MMM yyy',
                                            context.locale.languageCode)
                                        .format(state.client.birthday),
                                    style: TextStyle(
                                        color: FitnessColors.blindGray,
                                        fontSize: 16),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: null,
                                    child: AnimatedRotation(
                                      turns: _birthdayExpanded ? .25 : 0,
                                      curve: Curves.easeInOut,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: const Icon(
                                        CupertinoIcons.chevron_forward,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizeTransition(
                        sizeFactor: _birthdayExpandAnimation,
                        child: SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            initialDateTime: clientIsNew
                                ? state.client.birthday
                                : context
                                    .read<SelectedClientCubit>()
                                    .state
                                    .client!
                                    .birthday,
                            dateOrder: DatePickerDateOrder.dmy,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (DateTime value) {
                              context.read<ClientEditCubit>().update(
                                    state.client.copyWith(birthday: value),
                                  );
                            },
                          ),
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _weightExpanded = !_weightExpanded;
                          });
                          if (_weightExpanded) {
                            _weightExpandController.forward();
                          } else {
                            _weightExpandController.reverse();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.client_edit_page_weight.tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    _weight.toString(),
                                    style: TextStyle(
                                        color: FitnessColors.blindGray,
                                        fontSize: 16),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: null,
                                    child: AnimatedRotation(
                                      turns: _weightExpanded ? .25 : 0,
                                      curve: Curves.easeInOut,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: const Icon(
                                        CupertinoIcons.chevron_forward,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizeTransition(
                        sizeFactor: _weightExpandAnimation,
                        child: SizedBox(
                          height: 200,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: state.client.weight.toInt() - 1,
                            ),
                            itemExtent: 32,
                            onSelectedItemChanged: (index) {
                              context.read<ClientEditCubit>().update(
                                    state.client.copyWith(weight: index + 1),
                                  );
                              setState(() {
                                _weight = index + 1;
                              });
                            },
                            children: List<Widget>.generate(300, (int index) {
                              return Center(
                                child: Text(
                                  '${index + 1} kg',
                                  style: TextStyle(
                                    color: FitnessColors.black,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FieldTile(
                  text: LocaleKeys.client_edit_page_goal.tr(),
                  controller: _goalController..text = clientIsNew
                      ? ''
                      : context
                      .read<SelectedClientCubit>()
                      .state
                      .client!
                      .clientGoal,
                ),
                FieldTile(
                  text: LocaleKeys.client_edit_page_note.tr(),
                  controller: _noteController..text = clientIsNew
                      ? ''
                      : context
                      .read<SelectedClientCubit>()
                      .state
                      .client!
                      .clientNote,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 16),
                      child: Text(
                        LocaleKeys.client_edit_page_select_date_title.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: FitnessColors.blindGray,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: FitnessColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.client_edit_page_schedule.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          color: FitnessColors.blindGray,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DaySelector(
                              day: LocaleKeys.days_monday.tr(),
                              onPressed: () {

                              },
                            ),
                            DaySelector(
                              day: LocaleKeys.days_tuesday.tr(),
                              onPressed: () {},
                            ),
                            DaySelector(
                              day: LocaleKeys.days_wednesday.tr(),
                              onPressed: () {},
                            ),
                            DaySelector(
                              day: LocaleKeys.days_thursday.tr(),
                              onPressed: () {},
                            ),
                            DaySelector(
                              day: LocaleKeys.days_friday.tr(),
                              onPressed: () {},
                            ),
                            DaySelector(
                              day: LocaleKeys.days_saturday.tr(),
                              onPressed: () {},
                            ),
                            DaySelector(
                              day: LocaleKeys.days_sunday.tr(),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.client_edit_page_time.tr(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.all(8),
                              color: FitnessColors.whiteShaded,
                              child: Text(
                                _selectedTime.format(context),
                                style: TextStyle(
                                  color: FitnessColors.black,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: FitnessColors.white,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              _paidTrainingsExpanded = !_paidTrainingsExpanded;
                            });
                            if (_paidTrainingsExpanded) {
                              _paidExpandController.forward();
                            } else {
                              _paidExpandController.reverse();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.client_edit_page_paid_training.tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    state.client.payedTrainings.toString(),
                                    style: TextStyle(
                                      color: FitnessColors.blindGray,
                                      fontSize: 16,
                                    ),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: null,
                                    child: AnimatedRotation(
                                      turns: _paidTrainingsExpanded ? .25 : 0,
                                      curve: Curves.easeInOut,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: const Icon(
                                        CupertinoIcons.chevron_forward,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizeTransition(
                          sizeFactor: _paidExpandAnimation,
                          child: SizedBox(
                            height: 200,
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                initialItem: _paidTrainings,
                              ),
                              itemExtent: 32,
                              onSelectedItemChanged: (index) {
                                context.read<ClientEditCubit>().update(
                                      state.client
                                          .copyWith(payedTrainings: index),
                                    );
                              },
                              children: List<Widget>.generate(100, (int index) {
                                return Center(
                                  child: Text(
                                    '$index paid',
                                    style: TextStyle(
                                      color: FitnessColors.black,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
