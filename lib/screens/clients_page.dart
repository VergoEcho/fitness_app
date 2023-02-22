import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/bloc/clients_page_bloc/clients_page_bloc.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/ui/filled_button.dart';
import 'package:trainings/widgets/archived_client_card.dart';
import 'package:trainings/widgets/current_client_card.dart';

List<Client> _clients = [
  Client(
    id: 0,
    name: "Alexander",
    phone: "+1234678",
    birthday: "12.08.93",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 80,
  ),
  Client(
    id: 1,
    name: "Dmitriy",
    phone: "+12344278",
    birthday: "30.02.99",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 75,
    clientNote: "want to gain more muscle",
  ),
  Client(
    id: 2,
    name: "Karina",
    phone: "+12300231",
    birthday: "12.11.03",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 42,
    clientNote: "want to lose fat",
  ),
  Client(
    id: 2,
    name: "Diana",
    phone: "+1111231",
    birthday: "03.20.98",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    weight: 47,
    isArchive: true,
  ),
];

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  static const String route = '/clients';

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
                              onPressed: () {},
                            ),
                            CupertinoButton(
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
                          groupValue: state,
                          children: <ClientState, Widget>{
                            ClientState.current: Text(
                                '${LocaleKeys.clients_page_current.tr()} (10)'),
                            ClientState.archived:
                            Text('${LocaleKeys.clients_page_archive.tr()} (3)'),
                          },
                          onValueChanged: (value) {
                            context.read<ClientsPageBloc>().add(
                                ClientsPageModeChanged(value!));
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
                  List<Client> selectedClients() {
                    return _clients.where((client) {
                      if (state == ClientState.current) {
                        return client.isArchive == false;
                      }
                      return client.isArchive == true;
                    }).toList();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedClients().length,
                    itemBuilder: (context, index) {
                      Client client = selectedClients()[index];
                      if (state == ClientState.current) {
                        return CurrentClientCard(client: client);
                      }
                      return ArchivedClientCard(client: client);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
