import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainings/bloc/client_edit_cubit/client_edit_cubit.dart';
import 'package:trainings/bloc/clients_cubit/clients_cubit.dart';
import 'package:trainings/bloc/clients_page_bloc/clients_page_bloc.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';
import 'package:trainings/models/client.dart';
import 'package:trainings/common_widgets/filled_button.dart';
import 'package:trainings/screens/client_edit_page/client_edit_page.dart';
import 'package:trainings/screens/clients_page/widgets/archived_client_card.dart';
import 'package:trainings/screens/clients_page/widgets/current_client_card.dart';
import 'package:trainings/screens/settings_page.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  static const String route = '/clients';

  Future<void> _addNewClient (BuildContext context) {
    return Navigator.of(context, rootNavigator: true)
          .pushNamed(ClientEditPage.route)
          .then(
            (_) => Future.delayed(
          const Duration(milliseconds: 500),
              () => context
              .read<ClientEditCubit>()
              .clear(),
        ),
      );
  }

  void _openSettings(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
          .pushNamed(SettingsPage.route);
  }

  _changePageMode (BuildContext context, ClientsPageState value) {
    context
        .read<ClientsPageBloc>()
        .add(ClientsPageModeChanged(value));
  }

  Widget? _clientsCardBuilder(BuildContext context, int index) {
    ClientsPageState state = context.read<ClientsPageBloc>().state;
    Client client = selectedClients(
        context: context, state: state)[index];
    if (state == ClientsPageState.current) {
      return CurrentClientCard(client: client);
    }
    return ArchivedClientCard(client: client);
  }

  List<Client> selectedClients({
    required BuildContext context,
    required ClientsPageState state,
  }) {
    List<Client> clients = context.read<ClientsCubit>().state.clients;
    return clients.where((client) {
      if (state == ClientsPageState.current) {
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
              padding: const EdgeInsets.only(top: 32),
              decoration: BoxDecoration(
                color: FitnessColors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8),
                    child: Row(
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
                                onPressed: () => _addNewClient(context),
                              ),
                              CupertinoButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                onPressed: () => _openSettings(context),
                                child: SvgPicture.asset(
                                  'assets/images/cog.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<ClientsPageBloc, ClientsPageState>(
                        builder: (context, state) {
                          return CupertinoSlidingSegmentedControl<ClientsPageState>(
                            thumbColor: FitnessColors.white,
                            groupValue: state,
                            children: <ClientsPageState, Widget>{
                              ClientsPageState.current: Text(
                                '${LocaleKeys.clients_page_current.tr()} (${selectedClients(
                                  context: context,
                                  state: ClientsPageState.current,
                                ).length})',
                              ),
                              ClientsPageState.archived: Text(
                                '${LocaleKeys.clients_page_archive.tr()} (${selectedClients(
                                  context: context,
                                  state: ClientsPageState.archived,
                                ).length})',
                              ),
                            },
                            onValueChanged: (value) => _changePageMode(context, value!),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  BlocBuilder<ClientsPageBloc, ClientsPageState>(
                    builder: (context, state) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            selectedClients(context: context, state: state)
                                .length,
                        itemBuilder: _clientsCardBuilder,
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
