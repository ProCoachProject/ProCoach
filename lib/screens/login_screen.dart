import 'package:flutter/material.dart';
import 'package:pro_coach/screens/register_screen.dart';
import 'package:pro_coach/screens/trainee/trainee_login_screen.dart';
import 'package:pro_coach/widgets/custom_button.dart';

import '../widgets/custom_background.dart';
import 'coach/coach_login_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    'Sign in as:',
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
                                  builder: (context) => TraineeLoginScreen(),
                                ),
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
                                  builder: (context) => CoachLoginScreen(),
                                ),
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
                  Text(
                    'You don’t have an account ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff06283D),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    width: 190,
                    height: 60,
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
