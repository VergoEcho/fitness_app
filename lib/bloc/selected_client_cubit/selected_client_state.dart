part of 'selected_client_cubit.dart';

abstract class SelectedClientState extends Equatable {
  final Client? client;

  const SelectedClientState({this.client});

  @override
  List<Object?> get props => [client];
}

class SelectedClientNone extends SelectedClientState {
  const SelectedClientNone();
}

class SelectedClientSelected extends SelectedClientState {

  const SelectedClientSelected({required super.client});
}
