import 'package:flutter/material.dart';

/*
  example

*/

class DisableFormInputFieldWithIcon extends StatelessWidget {

  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final TextInputType keyboardType;
  final int? maxLines;

  DisableFormInputFieldWithIcon({
    required this.controller,
    required this.iconPrefix,
    required this.labelText,
    required this.keyboardType,
    this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      enabled: false,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(iconPrefix),
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 18, color: Colors.indigo, fontWeight: FontWeight.bold),
      ),
    );
  }
}
