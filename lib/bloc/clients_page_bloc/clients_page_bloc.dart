import 'package:bloc/bloc.dart';
part 'clients_page_event.dart';

enum ClientState { current, archived }

class ClientsPageBloc extends Bloc<ClientsPageEvent, ClientState> {
  ClientsPageBloc() : super(ClientState.current) {
    on<ClientsPageModeChanged>(_clientsPageModeChanged);
  }

  void _clientsPageModeChanged(
      ClientsPageModeChanged event, Emitter<ClientState> emit) async {

    if (event.value != state) {
      emit(event.value);
    }
  }
}
