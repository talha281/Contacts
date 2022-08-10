import 'package:flutter/material.dart';

class DashboardTile extends StatelessWidget {
  final String title;
  final void Function() onAdd;
  final void Function() onTap;
  const DashboardTile({
    Key? key,
    required this.title,
    required this.onAdd,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 14,
                  color: Colors.grey.withOpacity(0.25),
                  offset: const Offset(6, 5))
            ],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 32)),
            ),
            GestureDetector(
              onTap: onAdd,
              child: Container(
                // padding: const EdgeInsets.all(3),
                height: 50,
                width: 45,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    )),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
