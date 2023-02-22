import 'package:bloc/bloc.dart';
part 'client_profile_page_event.dart';

enum TrainingsOrInfo { trainings, info }

class ClientProfilePageBloc extends Bloc<ClientProfilePageEvent, TrainingsOrInfo> {
  ClientProfilePageBloc() : super(TrainingsOrInfo.trainings) {
    on<ClientProfilePageModeChanged>(_clientProfilePageModeChanged);
  }

  void _clientProfilePageModeChanged(
      ClientProfilePageModeChanged event, Emitter<TrainingsOrInfo> emit) async {

    if (event.value != state) {
      emit(event.value);
    }
  }
}
