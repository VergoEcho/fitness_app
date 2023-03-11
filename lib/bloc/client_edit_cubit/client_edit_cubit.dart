import 'package:bloc/bloc.dart';
import 'package:trainings/models/client.dart';

part 'client_edit_state.dart';

class ClientEditCubit extends Cubit<ClientEditState> {
  ClientEditCubit() : super(ClientEditState());

  update (Client client) {
    emit(ClientEditState(clientModel: client, selectedDay: state.selectedDay));
  }

  selectDay (String day) {
    emit(ClientEditState(clientModel: state.client, selectedDay: day));
  }

  clear () {
    emit(ClientEditState());
  }
}