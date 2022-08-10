import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String label;
  final int maxLines;
  const RoundTextField({
    Key? key,
    required this.controller,
    required this.inputType,
    required this.label,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 19, vertical: 2),
          label: Text(
            label,
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
      // style: TextStyle(
      //   fontSize: 17,
      // )
      // ,
    );
  }
}
