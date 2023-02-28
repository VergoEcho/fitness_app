import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/clients_page_bloc/clients_page_bloc.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/common_widgets/filled_button.dart';
import 'package:trainings/screens/client_edit_page/client_edit_page.dart';
import 'package:trainings/screens/clients_page/widgets/archived_client_card.dart';
import 'package:trainings/screens/clients_page/widgets/current_client_card.dart';

List<Client> _clients = [
  Client(
    id: 0,
    name: "Contact Name",
    phone: "+1234678",
    birthday: "12.08.93",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 80,
    clientNote: "Comment About",
    clientGoal: "Clients goal here",
  ),
  Client(
    id: 1,
    name: "Contact Name",
    phone: "+12344278",
    birthday: "30.02.99",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 75,
    clientNote: "Comment About",
    clientGoal: "Clients goal here",
  ),
  Client(
    id: 2,
    name: "Contact Name",
    phone: "+12300231",
    birthday: "12.11.03",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 42,
    clientNote: "Comment About",
    clientGoal: "Clients goal here",
  ),
  Client(
    id: 2,
    name: "Contact Name",
    phone: "+1111231",
    birthday: "03.20.98",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 47,
    isArchive: true,
    clientNote: "Comment About",
    clientGoal: "Clients goal here",
  ),
];

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  static const String route = '/clients';

  List<Client> selectedClients(ClientState state) {
    return _clients.where((client) {
      if (state == ClientState.current) {
        return client.isArchive == false;
      }
      return client.isArchive == true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: FitnessColors.whiteGray,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
              decoration: BoxDecoration(
                color: FitnessColors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.clients_page_title.tr(),
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppleFilledButton(
                              text: LocaleKeys.clients_page_new_client.tr(),
                              onPressed: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(ClientEditPage.route),
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              onPressed: () {},
                              child: const Icon(CupertinoIcons.settings),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<ClientsPageBloc, ClientState>(
                      builder: (context, state) {
                        return CupertinoSlidingSegmentedControl<ClientState>(
                          thumbColor: FitnessColors.white,
                          groupValue: state,
                          children: <ClientState, Widget>{
                            ClientState.current: Text(
                              '${LocaleKeys.clients_page_current.tr()} (${selectedClients(ClientState.current).length})',
                            ),
                            ClientState.archived: Text(
                              '${LocaleKeys.clients_page_archive.tr()} (${selectedClients(ClientState.archived).length})',
                            ),
                          },
                          onValueChanged: (value) {
                            context
                                .read<ClientsPageBloc>()
                                .add(ClientsPageModeChanged(value!));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ClientsPageBloc, ClientState>(
                builder: (context, state) {
                  // List<Client> selectedClients() {
                  //   return _clients.where((client) {
                  //     if (state == ClientState.current) {
                  //       return client.isArchive == false;
                  //     }
                  //     return client.isArchive == true;
                  //   }).toList();
                  // }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedClients(state).length,
                    itemBuilder: (context, index) {
                      Client client = selectedClients(state)[index];
                      if (state == ClientState.current) {
                        return CurrentClientCard(client: client);
                      }
                      return ArchivedClientCard(client: client);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}