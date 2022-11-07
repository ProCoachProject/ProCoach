import 'package:flutter/material.dart';
import 'package:pro_coach/screens/login_screen.dart';
import 'package:pro_coach/services/supabase_service.dart';
import 'package:pro_coach/widgets/custom_button.dart';

import '../../widgets/custom_background.dart';

class CoachWaitingScreen extends StatefulWidget {
  const CoachWaitingScreen({Key? key}) : super(key: key);

  @override
  State<CoachWaitingScreen> createState() => _CoachWaitingScreenState();
}

class _CoachWaitingScreenState extends State<CoachWaitingScreen> {
  Future<void> signOut() async {
    await SupabaseService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
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
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/Waiting.png'),
                        height: 230,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Thank you for joining us in \nPro Coach\n\nOur team will contact you after reviewing your account.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          child: Text(
                            'Log Out',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          width: 200,
                          height: 50,
                          onPress: signOut),
                      SizedBox(
                        height: 20,
                      ),
                      Image(
                        width: 200,
                        image: AssetImage('assets/images/Logo.png'),
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
