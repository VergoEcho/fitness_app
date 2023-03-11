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

import 'widgets/birthday_weight_picker.dart';
import 'widgets/day_time_picker.dart';
import 'widgets/paid_trainings_picker.dart';

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
  late double _weight;
  bool _weightExpanded = false;
  late final AnimationController _weightExpandController;
  late int _paidTrainings;
  bool _paidTrainingsExpanded = false;
  late final AnimationController _paidExpandController;
  String? editDay;
  bool _timeExpanded = false;
  late final AnimationController _timeExpandController;
  bool clientInitialized = false;
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _selectedDayExpandController;

  final _formKey = GlobalKey<FormState>();

  _closeExpanded() {
    _birthdayExpanded = false;
    _weightExpanded = false;
    _timeExpanded = false;
    _paidTrainingsExpanded = false;
  }

  _reversePickerControllers() {
    _birthdayExpandController.reverse();
    _weightExpandController.reverse();
    _timeExpandController.reverse();
    _paidExpandController.reverse();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _goalController.dispose();
    _noteController.dispose();

    _scrollController.dispose();

    _birthdayExpandController.dispose();
    _weightExpandController.dispose();
    _timeExpandController.dispose();
    _paidExpandController.dispose();
    _selectedDayExpandController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _birthday = DateTime.now();
    _weight = 70;
    _paidTrainings = 0;

    _birthdayExpandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _weightExpandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _timeExpandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _selectedDayExpandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _paidExpandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    super.initState();
  }

  _submitForm(BuildContext context) {
    bool valid = _formKey.currentState!.validate();
    if (valid) {
      bool clientIsNew =
      context.read<SelectedClientCubit>().state is SelectedClientNone;
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
            _weight = client.weight;
            _birthday = client.birthday;
            _paidTrainings = client.paidTrainings;
            Client formClient =
                state.client.copyWith(trainingDays: client.trainingDays);
            Future.delayed(const Duration(milliseconds: 100),
                () => context.read<ClientEditCubit>().update(formClient));
          } else {
            _weight = state.client.weight;
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
                      ? LocaleKeys.client_edit_page_done.tr()
                      : LocaleKeys.client_edit_page_save.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              onPressed: () => _submitForm(context),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              controller: _scrollController,
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
                BirthdayWeightPicker(
                  onBirthdayTapped: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      _closeExpanded();
                      _birthdayExpanded = !_birthdayExpanded;
                    });
                    _reversePickerControllers();
                    if (_birthdayExpanded) {
                      _birthdayExpandController.forward();
                    }
                  },
                  birthday: _birthday,
                  birthdayExpanded: _birthdayExpanded,
                  birthdayExpandController: _birthdayExpandController,
                  onBirthdayDateChanged: (DateTime value) {
                    setState(() {
                      _birthday = value;
                    });
                  },
                  initialBirthdayDate: clientIsNew
                      ? state.client.birthday
                      : context
                          .read<SelectedClientCubit>()
                          .state
                          .client!
                          .birthday,
                  weightExpandController: _weightExpandController,
                  onWeightTapped: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      _closeExpanded();
                      _weightExpanded = !_weightExpanded;
                    });
                    _reversePickerControllers();
                    if (_weightExpanded) {
                      _weightExpandController.forward();
                    }
                  },
                  initialWeight: clientIsNew
                      ? state.client.weight.toInt() - 1
                      : context
                              .read<SelectedClientCubit>()
                              .state
                              .client!
                              .weight
                              .toInt() -
                          1,
                  weightExpanded: _weightExpanded,
                  weight: _weight,
                  onWeightValueChanged: (index) {
                    setState(() {
                      _weight = index + 1;
                    });
                  },
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
                DayTimePicker(
                  selectedDayExpandController: _selectedDayExpandController,
                  timeExpandController: _timeExpandController,
                  onDaySelectorPressed: (String day) {
                    if (state.selectedDay == '') {
                      _selectedDayExpandController.forward();
                    }
                    context.read<ClientEditCubit>().selectDay(day);
                  },
                  onTimePressed: () {
                    _scrollController.animateTo(
                      160,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      _closeExpanded();
                      _timeExpanded = !_timeExpanded;
                    });
                    _reversePickerControllers();
                    if (_timeExpanded) {
                      _timeExpandController.forward();
                    }
                  },
                  onDateTimeChanged: (DateTime value) {
                    Client client = state.client;
                    client.trainingDays[state.selectedDay] =
                        TimeOfDay.fromDateTime(value);
                    context.read<ClientEditCubit>().update(client);
                  },
                ),
                PaidTrainingsPicker(
                  paidTrainings: _paidTrainings,
                  expanded: _paidTrainingsExpanded,
                  expandController: _paidExpandController,
                  onTap: () {
                    _scrollController.animateTo(
                      160,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      _closeExpanded();
                      _paidTrainingsExpanded = !_paidTrainingsExpanded;
                    });
                    _reversePickerControllers();
                    if (_paidTrainingsExpanded) {
                      _paidExpandController.forward();
                    }
                  },
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _paidTrainings = index;
                    });
                  },
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
