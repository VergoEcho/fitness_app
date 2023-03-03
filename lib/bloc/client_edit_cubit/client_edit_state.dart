part of 'client_edit_cubit.dart';

class ClientEditState {
  final Client client;

  ClientEditState({Client? clientModel})
      : client = clientModel ?? Client(
          id: 0,
          name: '',
          phone: '',
          weight: 80,
          birthday: DateTime(2000, 1, 1)
        );
}

// abstract class SelectedClientState extends Equatable {
//   final Client? client;
//
//   const SelectedClientState({this.client});
//
//   @override
//   List<Object?> get props => [client];
// }
//
// class SelectedClientNone extends SelectedClientState {
//   const SelectedClientNone();
// }
//
// class SelectedClientSelected extends SelectedClientState {
//
//   const SelectedClientSelected({required super.client});
// }
