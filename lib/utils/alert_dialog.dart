import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showAlert(
  BuildContext context,
  String title,
  String desc,
  AlertType type, {
  void Function()? onPressed,
}) {
  Alert(
    context: context,
    title: title,
    desc: desc,
    type: type,
    buttons: [
      DialogButton(
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 26),
        ),
        onPressed: onPressed,
      ),
    ],
  ).show();
}
