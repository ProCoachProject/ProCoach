import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro_coach/services/supabase_service.dart';

import '../screens/login_screen.dart';

class CustomSignOutButton extends StatelessWidget {
  const CustomSignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(1000),
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.transparent,
        onTap: () async {
          await SupabaseService.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(180 / 360),
          child: Icon(FontAwesomeIcons.signOut),
        ),
      ),
    );
  }
}
