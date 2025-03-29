// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/transaction__response.dart';


import '../../../constants.dart';


class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key, required this.tran,
  });
  final TransactionResponse tran;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppDialog.showDetailTransaction(context, tran);
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusOfItems(numOfItem: tran.status),
              const SizedBox(width: defaultPadding * 0.75),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tran.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    Text(
                      tran.type.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding / 2),
              Text(
                "VNĐ ${tran.currentBalance}",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: primaryColor),
              )
            ],
          ),
          const SizedBox(height: defaultPadding / 2),
          const Divider(),
        ],
      ),
    );
  }
}

class StatusOfItems extends StatelessWidget {
  const StatusOfItems({
    super.key,
    required this.numOfItem,
  });

  final TransactionStatus numOfItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      
      ),
      child: CircleAvatar(
        backgroundColor: numOfItem == TransactionStatus.COMPLETED ? Colors.green : numOfItem == TransactionStatus.FAILED ? Colors.red : Colors.yellow,
        child: Icon(
          numOfItem == TransactionStatus.COMPLETED ? Icons.check : numOfItem == TransactionStatus.FAILED ? Icons.close : Icons.warning,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
