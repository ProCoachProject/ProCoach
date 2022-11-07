import 'package:flutter/material.dart';
import 'package:pro_coach/models/activity.dart';
import 'package:pro_coach/models/coach.dart';

import '../models/trainee.dart';

class CustomBioTextField extends StatelessWidget {
  CustomBioTextField({
    required this.label,
    required this.whoWillChange,
    required this.account,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
  });

  final String account;
  final String label;
  final bool obscureText;
  final TextInputType textInputType;
  late String whoWillChange;

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: TextField(
        maxLines: null,
        minLines: null,
        expands: true,
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
        ),
        controller: controller,
        onChanged: (value) {
          if (account == 'T') {
            Trainee.changer(value, whoWillChange);
          } else if (account == 'C') {
            Coach.changer(value, whoWillChange);
          } else if (account == 'A') {
            Activity.changer(value, whoWillChange);
          }
        },
      ),
    );
  }
}
