import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trainings/models/client.dart';

part 'clients_state.dart';


List<Client> _clients = [
  Client(
    id: 0,
    name: "Contact Name",
    clientNote: "Comment About",
    phone: "+1234678",
    birthday: "12.08.93",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
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
    clientNote: "Comment About",
    phone: "+12344278",
    birthday: "30.02.99",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
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
    birthday: "12.11.03",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 42,
    trainingDays: const {
      "monday": TimeOfDay(hour: 15, minute: 00),
      "wednesday": TimeOfDay(hour: 15, minute: 00),
      "thursday": TimeOfDay(hour: 15, minute: 00),
    },
    clientNote: "Comment About",
  ),
  Client(
    id: 2,
    name: "Contact Name",
    clientNote: "Comment About",
    phone: "+1111231",
    birthday: "03.20.98",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
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
