import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/ui/filled_button.dart';
import 'package:trainings/widgets/archived_client_card.dart';
import 'package:trainings/widgets/current_client_card.dart';

enum ClientState { current, archived }

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  static const String route = '/clients';

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  ClientState pageMode = ClientState.current;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xfffafafa),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.all(
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (pageMode == ClientState.current) {
                    return const CurrentClientCard();
                  } else {
                    return const ArchivedClientCard();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
