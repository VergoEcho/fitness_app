import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainings/models/client.dart';

class ArchivedClientCard extends StatelessWidget {
  const ArchivedClientCard({Key? key, required this.client})
      : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(client.name),
              client.clientNote == ""
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        client.clientNote,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0x963c3c43)),
                      ),
                    ),
            ],
          ),
          CupertinoButton(
            onPressed: () {},
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0x963c3c43),
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
