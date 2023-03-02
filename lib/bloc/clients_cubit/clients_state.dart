part of 'clients_cubit.dart';

enum ClientsStatus { initial, success, failure }

class ClientsState extends Equatable {
  final ClientsStatus status;
  final List<Client> clients;

  const ClientsState({
    this.clients = const <Client>[],
    required this.status,
  });

  @override
  List<Object?> get props => [clients, status];
}
