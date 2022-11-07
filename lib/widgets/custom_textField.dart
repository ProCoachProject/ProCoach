import 'package:flutter/material.dart';
import 'package:pro_coach/models/coach.dart';

import '../models/activity.dart';
import '../models/trainee.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.label,
    required this.whoWillChange,
    required this.account,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.initialValue = '',
  });

  final String account;
  final String initialValue;
  final String label;
  final bool obscureText;
  final TextInputType textInputType;
  late String whoWillChange;

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = initialValue;

    return TextField(
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
    );
  }
}
