import 'package:flutter/material.dart';
import 'package:pro_coach/models/trainee.dart';
import 'package:pro_coach/screens/trainee/image_picker.dart';
import 'package:pro_coach/services/supabase_service.dart';
import 'package:pro_coach/widgets/custom_background.dart';
import 'package:pro_coach/widgets/custom_button.dart';
import 'package:pro_coach/widgets/custom_date_textField.dart';

import '../../widgets/custom_textField.dart';
import 'trainee_home_screen.dart';

class TraineeRegisterScreen extends StatefulWidget {
  const TraineeRegisterScreen({Key? key}) : super(key: key);

  @override
  State<TraineeRegisterScreen> createState() => _TraineeRegisterScreenState();
}

class _TraineeRegisterScreenState extends State<TraineeRegisterScreen> {
  Future<void> register(context) async {
    try {
      bool matched = Trainee.pass == Trainee.confPass;
      if (matched) {
        await SupabaseService.registerWithEmail(
            email: Trainee.email, password: Trainee.pass);
        await SupabaseService.addTraineeInfo(
          tid: SupabaseService.supabaseClient.auth.currentUser?.id,
          name: Trainee.name,
          city: Trainee.city,
          phone: Trainee.phone,
          dob: Trainee.dob,
          imageFileName: Trainee.imageFileName,
          imageFile: Trainee.imageFile,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TraineeHomeScreen()),
        );
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'The Passwords are not Matching',
                  textAlign: TextAlign.center,
                ),
              );
            });
      }
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Please Check If Your Information Is Correct',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      body: Stack(
        children: [
          CustomBackground(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register :',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //Text Field
                      Center(child: TraineeImagePicker()),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Email',
                        whoWillChange: 'Email',
                        account: 'T',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Password',
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
                      CustomTextField(
                        label: 'Name',
                        whoWillChange: 'Name',
                        account: 'T',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'City',
                        whoWillChange: 'City',
                        account: 'T',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
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
                        height: 30,
                      ),

                      Center(
                        child: CustomButton(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            width: 200,
                            height: 50,
                            onPress: () {
                              register(context);
                            }),
                      )
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
