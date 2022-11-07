import 'package:flutter/material.dart';
import 'package:pro_coach/screens/startup_screen.dart';
import 'package:pro_coach/services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initializeSupabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartupScreen(),
    );
  }
}
