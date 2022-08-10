import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'amount.dart';

class Tile extends StatelessWidget {
  final void Function() edit, delete, onTap;
  final String name;
  final int id, records;
  final bool showEditDelete;
  final double income, expense, revenue;
  const Tile({
    Key? key,
    required this.delete,
    required this.onTap,
    required this.edit,
    required this.id,
    required this.name,
    required this.records,
    required this.income,
    required this.expense,
    required this.revenue,
    this.showEditDelete = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            // border: Border(
            //     bottom: BorderSide(
            //         color: Theme.of(context).primaryColor, width: 2)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.withOpacity(0.25),
                  offset: const Offset(6, 5))
            ],
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          children: [
            if (showEditDelete)
              Column(
                children: [
                  GestureDetector(
                    onTap: edit,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          // color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(25))),
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: delete,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(25))),
                      child:
                          const Icon(Icons.delete_outline, color: Colors.red),
                    ),
                  ),
                ],
              ),
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 4),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.height / 16,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            name,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "$records",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "  Records",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(children: [
              AmountChangeWidget(
                amount: income,
                icon: FontAwesomeIcons.chevronCircleDown,
                textColor: Colors.green,
                color: Colors.green,
              ),
              AmountChangeWidget(
                amount: expense,
                icon: FontAwesomeIcons.chevronCircleUp,
                color: Colors.red,
                textColor: Colors.red,
              ),
              AmountChangeWidget(
                amount: revenue,
                icon: FontAwesomeIcons.rupeeSign,
                color: (revenue.isNegative) ? Colors.red : Colors.green,
                textColor: (revenue.isNegative) ? Colors.red : Colors.green,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
