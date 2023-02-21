import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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

enum ClientState { current, archived }

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  static const String route = '/clients';

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  ClientState pageMode = ClientState.current;

  List<Client> _selectedClients () {
    return _clients.where((client) {
      if (pageMode == ClientState.current) {
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
                    child: CupertinoSlidingSegmentedControl<ClientState>(
                      groupValue: pageMode,
                      children: <ClientState, Widget>{
                        ClientState.current: Text(
                            '${LocaleKeys.clients_page_current.tr()} (10)'),
                        ClientState.archived:
                            Text('${LocaleKeys.clients_page_archive.tr()} (3)'),
                      },
                      onValueChanged: (state) {
                        setState(() {
                          if (pageMode != state) {
                            pageMode = state!;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _selectedClients().length,
                itemBuilder: (context, index) {
                  Client client = _selectedClients()[index];
                  if (pageMode == ClientState.current) {
                    return CurrentClientCard(client: client);
                  }
                  return ArchivedClientCard(client: client);

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
