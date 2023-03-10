import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/constants/colors.dart';
import 'package:trainings/models/client.dart';

class ArchivedClientCard extends StatelessWidget {
  const ArchivedClientCard({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: FitnessColors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                client.clientNote == ""
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          client.clientNote,
                          style: TextStyle(
                              fontSize: 14, color: FitnessColors.blindGray),
                        ),
                      ),
              ],
            ),
          ),
          CupertinoButton(
            onPressed: () {},
            child: Icon(
              Icons.arrow_forward_ios,
              color: FitnessColors.darkGray,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
