import 'package:flutter/material.dart';
import 'package:pro_coach/screens/coach/coach_home_screen.dart';
import 'package:pro_coach/screens/coach/coach_waiting_screen.dart';
import 'package:pro_coach/screens/login_screen.dart';
import 'package:pro_coach/screens/trainee/trainee_home_screen.dart';
import 'package:pro_coach/services/supabase_service.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    await Future.delayed(Duration(seconds: 3));
    final int coachNotVerified = await SupabaseService.checkIfVerified();
    if (await SupabaseService.supabaseClient.auth.currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else if (coachNotVerified == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CoachWaitingScreen()),
      );
    } else if (coachNotVerified == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CoachHomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TraineeHomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(
            image: AssetImage('assets/images/Logo.png'),
          ),
          Text(
            'Pro Coach',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color(0xff1B262C)),
          ),
        ],
      ),
    );
  }
}
