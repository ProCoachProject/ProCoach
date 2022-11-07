import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required String alertTitle,
  required Function() onPressed,
}) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Yes"),
    onPressed: onPressed,
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(alertTitle),
    content: Text("Are You Sure?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
