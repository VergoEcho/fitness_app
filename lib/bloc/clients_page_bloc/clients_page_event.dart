part of 'clients_page_bloc.dart';

abstract class ClientsPageEvent {
  const ClientsPageEvent();
}

class ClientsPageModeChanged extends ClientsPageEvent {
  const ClientsPageModeChanged(this.value);
  final ClientsPageState value;
}