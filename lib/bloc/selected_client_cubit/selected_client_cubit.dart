import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainings/models/client.dart';

part 'selected_client_state.dart';

class SelectedClientCubit extends Cubit<SelectedClientState> {
  SelectedClientCubit() : super(const SelectedClientNone());

  void select(Client client) {
    emit(SelectedClientSelected(client: client));
  }
}
