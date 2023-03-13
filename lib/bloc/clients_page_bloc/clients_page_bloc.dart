import 'package:bloc/bloc.dart';
part 'clients_page_event.dart';

enum ClientsPageState { current, archived }

class ClientsPageBloc extends Bloc<ClientsPageEvent, ClientsPageState> {
  ClientsPageBloc() : super(ClientsPageState.current) {
    on<ClientsPageModeChanged>(_clientsPageModeChanged);
  }

  void _clientsPageModeChanged(
      ClientsPageModeChanged event, Emitter<ClientsPageState> emit) async {

    if (event.value != state) {
      emit(event.value);
    }
  }
}
