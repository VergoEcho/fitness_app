part of 'client_profile_page_bloc.dart';

abstract class ClientProfilePageEvent {
  const ClientProfilePageEvent();
}

class ClientProfilePageModeChanged extends ClientProfilePageEvent {
  const ClientProfilePageModeChanged(this.value);
  final TrainingsOrInfo value;
}