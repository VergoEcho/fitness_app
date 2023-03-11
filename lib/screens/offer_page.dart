import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/generated/locale_keys.g.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({Key? key}) : super(key: key);

  static const String route = '/offer';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: FitnessColors.whiteBlue,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: FitnessColors.blueGradient,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 72.0),
                  child: Column(
                    children: [
                      Text(
                        LocaleKeys.offer_page_title.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          color: FitnessColors.white,
                        ),
                      ),
                      Text(
                        LocaleKeys.offer_page_subtitle.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 28,
                          color: FitnessColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        children: [
                          Text(
                            LocaleKeys.offer_page_features_title.tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                    CupertinoIcons.checkmark_alt_circle_fill),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    LocaleKeys
                                        .offer_page_features_unlimited_templates
                                        .tr(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                    CupertinoIcons.checkmark_alt_circle_fill),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    LocaleKeys.offer_page_features_archive_clients
                                        .tr(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                    CupertinoIcons.checkmark_alt_circle_fill),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    LocaleKeys
                                        .offer_page_features_unlimited_clients
                                        .tr(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: FitnessColors.orange,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                )),
                            child: Text(
                              LocaleKeys.offer_page_subscribe.tr(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: CupertinoButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                LocaleKeys.offer_page_cancel.tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: FitnessColors.darkGray,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
