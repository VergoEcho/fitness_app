import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/client_edit_cubit/client_edit_cubit.dart';
import 'package:trainings/bloc/selected_client_cubit/selected_client_cubit.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/common_widgets/field_tile.dart';
import 'package:trainings/models/client.dart';

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
  bool _timeExpanded = false;
  late final AnimationController _timeExpandController;
  late final Animation<double> _timeExpandAnimation;
  bool clientInitialized = false;
  String _selectedDay = '';

  final _formKey = GlobalKey<FormState>();

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
    _timeExpandController.dispose();
    _paidExpandController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _birthday = DateTime.now();
    _weight = 70;
    _paidTrainings = 0;
    _selectedTime = const TimeOfDay(hour: 0, minute: 00);

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

    _timeExpandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _timeExpandAnimation = CurvedAnimation(
      parent: _timeExpandController,
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

  TimeOfDay _selectedDayTime(ClientEditState state) {
    return state.client.trainingDays[_selectedDay] ?? _selectedTime;
  }

  String _selectedDayTimeString(ClientEditState state) {
    TimeOfDay time = _selectedDayTime(state);
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    bool clientIsNew =
        context.read<SelectedClientCubit>().state is SelectedClientNone;

    return BlocBuilder<ClientEditCubit, ClientEditState>(
      builder: (context, state) {
        if (!clientInitialized) {
          if (!clientIsNew) {
            Client client = context.read<SelectedClientCubit>().state.client!;
            _weight = client.weight.toInt();
            _birthday = client.birthday;
            _paidTrainings = client.paidTrainings;
            Client formClient =
                state.client.copyWith(trainingDays: client.trainingDays);
            Future.delayed(const Duration(milliseconds: 100),
                () => context.read<ClientEditCubit>().update(formClient));
          } else {
            _weight = state.client.weight.toInt();
            _birthday = state.client.birthday;
          }
          clientInitialized = true;
        }
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
              clientIsNew
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
                _formKey.currentState!.validate();
                if (_nameController.text.isEmpty) {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(LocaleKeys
                              .client_edit_page_error_name_title
                              .tr()),
                          content: Text(
                            LocaleKeys.client_edit_page_error_name_description
                                .tr(),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          actions: [
                            CupertinoButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                LocaleKeys.client_edit_page_error_name_confirm
                                    .tr(),
                              ),
                            )
                          ],
                        );
                      });
                } else {
                  // Validation passed
                  if (clientIsNew) {
                    // Client newClient = state.client.copyWith(
                    //   id: context.read<ClientsCubit>().state.clients.length,
                    //   name: _nameController.text,
                    //   phone: _phoneController.text,
                    //   birthday: _birthday,
                    //   weight: _weight.toDouble(),
                    //   clientGoal: _goalController.text,
                    //   clientNote: _noteController.text,
                    //   paidTrainings: _paidTrainings,
                    // );
                    // context.read<ClientsCubit>().addClient(newClient);
                  }
                  Navigator.pop(context);
                }
              },
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                FieldTile(
                  validator: (String? text) {
                    if (text == null || text.isEmpty || text == '') {
                      return LocaleKeys.client_edit_page_error_name_field.tr();
                    }
                    return null;
                  },
                  formKey: _formKey,
                  controller: _nameController
                    ..text = clientIsNew
                        ? ''
                        : context
                            .read<SelectedClientCubit>()
                            .state
                            .client!
                            .name,
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
                                        .format(_birthday),
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
                              setState(() {
                                _birthday = value;
                              });
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
                              initialItem: clientIsNew
                                  ? state.client.weight.toInt() - 1
                                  : context
                                          .read<SelectedClientCubit>()
                                          .state
                                          .client!
                                          .weight
                                          .toInt() -
                                      1,
                            ),
                            itemExtent: 32,
                            onSelectedItemChanged: (index) {
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
                  controller: _goalController
                    ..text = clientIsNew
                        ? ''
                        : context
                            .read<SelectedClientCubit>()
                            .state
                            .client!
                            .clientGoal,
                ),
                FieldTile(
                  text: LocaleKeys.client_edit_page_note.tr(),
                  controller: _noteController
                    ..text = clientIsNew
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
                          children:
                              state.client.trainingDays.entries.map((day) {
                            return DaySelector(
                                clearTime: () {
                                  Client client = state.client;
                                  client.trainingDays[day.key] = null;
                                  context
                                      .read<ClientEditCubit>()
                                      .update(client);
                                },
                                time: day.value,
                                selectedDay: _selectedDay,
                                onPressed: () {
                                  setState(() {
                                    _selectedDay = day.key;
                                  });
                                },
                                day: day.key.substring(0, 3));
                          }).toList(),
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
                              onPressed: _selectedDay == ''
                                  ? null
                                  : () {
                                      setState(() {
                                        _timeExpanded = !_timeExpanded;
                                      });
                                      if (_timeExpanded) {
                                        _timeExpandController.forward();
                                      } else {
                                        _timeExpandController.reverse();
                                      }
                                    },
                              child: Text(
                                _selectedDayTimeString(state),
                                style: TextStyle(
                                  color: FitnessColors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizeTransition(
                        sizeFactor: _timeExpandAnimation,
                        child: SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            use24hFormat: true,
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (DateTime value) {
                              Client client = state.client;
                              client.trainingDays[_selectedDay] =
                                  TimeOfDay.fromDateTime(value);
                              context.read<ClientEditCubit>().update(client);
                            },
                          ),
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
                                    _paidTrainings.toString(),
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
                                setState(() {
                                  _paidTrainings = index;
                                });
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
