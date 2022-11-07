import 'package:flutter/material.dart';
import 'package:pro_coach/screens/coach/coach_register_screen.dart';
import 'package:pro_coach/screens/trainee/trainee_register_screen.dart';
import 'package:pro_coach/widgets/custom_button.dart';

import '../widgets/custom_background.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      body: SafeArea(
        child: Stack(
          children: [
            //backGround Design
            CustomBackground(),

            //body
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register as:',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff06283D),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CustomButton(
                            child: Center(
                              child: Image(
                                width: 160,
                                image: AssetImage(
                                    'assets/images/Trainee_Logo.png'),
                              ),
                            ),
                            width: 180,
                            height: 180,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TraineeRegisterScreen()),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Trainee',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff06283D),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          CustomButton(
                            child: Center(
                              child: Image(
                                width: 160,
                                image:
                                    AssetImage('assets/images/Coach_Logo.png'),
                              ),
                            ),
                            width: 180,
                            height: 180,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CoachRegisterScreen()),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Coach',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff06283D),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Image(
                    width: 200,
                    image: AssetImage('assets/images/Logo.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
