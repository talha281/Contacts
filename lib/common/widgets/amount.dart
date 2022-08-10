import 'package:flutter/material.dart';

class AmountChangeWidget extends StatelessWidget {
  final double amount;
  final Color color;
  final Color textColor;
  final IconData icon;
  const AmountChangeWidget({
    Key? key,
    required this.amount,
    required this.color,
    required this.icon,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 11,
          color: color,
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 4.5,
          height: 18,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              " ${amount.toStringAsFixed(2)}",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: textColor, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
