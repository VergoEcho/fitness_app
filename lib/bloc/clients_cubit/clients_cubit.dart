import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trainings/models/client.dart';

part 'clients_state.dart';


List<Client> _clients = [
  Client(
    id: 0,
    name: "Contact Name",
    clientGoal: "Clients goal here",
    clientNote: "Comment About",
    phone: "+1234678",
    birthday: DateTime(1988, 4, 1),
    trainingDays: const {
      "monday": TimeOfDay(hour: 13, minute: 00),
      "wednesday": TimeOfDay(hour: 13, minute: 00),
      "thursday": TimeOfDay(hour: 13, minute: 00),
    },
    weight: 80,
  ),
  Client(
    id: 1,
    name: "Contact Name",
    clientGoal: "Clients goal here",
    clientNote: "Comment About",
    phone: "+12344278",
    birthday: DateTime(1999, 9, 23),
    trainingDays: const {
      "monday": TimeOfDay(hour: 14, minute: 00),
      "wednesday": TimeOfDay(hour: 14, minute: 00),
      "friday": TimeOfDay(hour: 14, minute: 00),
    },
    weight: 75,
  ),
  Client(
    id: 2,
    name: "Contact Name",
    phone: "+12300231",
    birthday: DateTime(2003, 11, 12),
    weight: 42,
    trainingDays: const {
      "monday": TimeOfDay(hour: 15, minute: 00),
      "wednesday": TimeOfDay(hour: 15, minute: 00),
      "thursday": TimeOfDay(hour: 15, minute: 00),
    },
    clientGoal: "Clients goal here",
    clientNote: "Comment About",
  ),
  Client(
    id: 2,
    name: "Contact Name",
    clientNote: "Comment About",
    clientGoal: "Clients goal here",
    phone: "+1111231",
    birthday: DateTime(2001, 11, 6),
    weight: 47,
    trainingDays: const {
      "monday": TimeOfDay(hour: 18, minute: 00),
      "friday": TimeOfDay(hour: 18, minute: 00),
    },
    isArchive: true,
  ),
];

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit() : super(const ClientsState(status: ClientsStatus.initial));

  void fetchClients () {
    emit(ClientsState(status: ClientsStatus.success, clients: _clients));
  }
}
