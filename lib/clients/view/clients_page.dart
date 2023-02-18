import 'package:flutter/cupertino.dart';

import 'package:trainings/clients/widgets/widgets.dart';

enum ClientState { current, archived }

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

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
                        const Expanded(
                          child: Text(
                            'Clients',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton.filled(
                                borderRadius: BorderRadius.circular(100),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                minSize: 32,
                                onPressed: () {},
                                child: Text(
                                  'New Client'.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
                    CupertinoSlidingSegmentedControl<ClientState>(
                      groupValue: pageMode,
                      children: const <ClientState, Widget>{
                        ClientState.current: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 48),
                            child: Text('Current (10)')),
                        ClientState.archived:
                            Text('Archive (3)'),
                      },
                      onValueChanged: (state) {
                        setState(() {
                          if (pageMode != state) {
                            pageMode = state!;
                          }
                        });
                      },
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
                    }
                    if (pageMode == ClientState.archived) {
                      return const ArchivedClientCard();
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        ));
  }
}
