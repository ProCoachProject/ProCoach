import 'package:flutter/material.dart';
import 'package:pro_coach/models/trainee.dart';

class CustomDateTextField extends StatelessWidget {
  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateInput, //editing controller of this TextField
      decoration: InputDecoration(
        //icon of text field
        labelText: "Enter Date Of Birth", //label text of field
        filled: true,
        fillColor: Colors.white,
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          dateInput.text =
              '${pickedDate.month}/${pickedDate.day}/${pickedDate.year}';
          Trainee.changeDob(pickedDate.year, pickedDate.month, pickedDate.day);
        } else {
          print("Date is not selected");
        }
      },
    );
  }
}
