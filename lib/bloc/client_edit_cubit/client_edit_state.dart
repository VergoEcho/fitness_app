part of 'client_edit_cubit.dart';

class ClientEditState {
  final Client client;
  final String selectedDay;

  ClientEditState({Client? clientModel, this.selectedDay = ''})
      : client = clientModel ?? Client(
          id: 0,
          name: '',
          phone: '',
          weight: 80,
          birthday: DateTime(2000, 1, 1)
        );
}