import 'package:flutter/material.dart';
import 'package:pro_coach/widgets/custom_button.dart';
import 'package:pro_coach/widgets/custom_image_picker.dart';

import '../../widgets/custom_background.dart';
import '../widgets/custom_date_textField.dart';
import '../widgets/custom_textField.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({
    required this.name,
    required this.city,
    required this.phone,
  });

  final String name;
  final String city;
  final String phone;
  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      body: Stack(
        children: [
          CustomBackground(),
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CustomImagePicker(
                        title: 'Edit Your Picture',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        initialValue: widget.name,
                        label: 'Name',
                        whoWillChange: 'Name',
                        account: 'T',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        initialValue: widget.city,
                        label: 'City',
                        whoWillChange: 'City',
                        account: 'T',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        initialValue: widget.phone,
                        label: 'Phone Number',
                        whoWillChange: 'Phone',
                        account: 'T',
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDateTextField(),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Current Paswword',
                        whoWillChange: 'Password',
                        account: 'T',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'New Password',
                        whoWillChange: 'Password',
                        account: 'T',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Confirm Password',
                        whoWillChange: 'ConfPassword',
                        account: 'T',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        child: Text(
                          'Save',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        width: 200,
                        height: 50,
                        onPress: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Updated Successfully',
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              });
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
