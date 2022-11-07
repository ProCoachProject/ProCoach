import 'package:flutter/material.dart';
import 'package:pro_coach/screens/coach/coach_home_screen.dart';
import 'package:pro_coach/services/supabase_service.dart';
import 'package:pro_coach/widgets/custom_background.dart';
import 'package:pro_coach/widgets/custom_button.dart';

import '../../models/coach.dart';
import '../../widgets/custom_textField.dart';
import 'coach_waiting_screen.dart';

class CoachLoginScreen extends StatefulWidget {
  const CoachLoginScreen({Key? key}) : super(key: key);

  @override
  State<CoachLoginScreen> createState() => _CoachLoginScreenState();
}

class _CoachLoginScreenState extends State<CoachLoginScreen> {
  Future<void> login(context) async {
    try {
      await SupabaseService.loginWithEmail(
          email: Coach.email, password: Coach.pass);
      if (await SupabaseService.checkIfVerified() == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CoachWaitingScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CoachHomeScreen()),
        );
      }
    } catch (e) {
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In :',
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
                  CustomTextField(
                    label: 'Email',
                    whoWillChange: 'Email',
                    account: 'C',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    label: 'Password',
                    whoWillChange: 'Password',
                    account: 'C',
                    obscureText: true,
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Center(
                    child: CustomButton(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        width: 200,
                        height: 50,
                        onPress: () {
                          login(context);
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
