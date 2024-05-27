import 'package:elp_task1/payroll_screen.dart';
import 'package:elp_task1/scheduling_screen.dart';
import 'package:elp_task1/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'chat_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'splash_screen.dart';  // Import the splash screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        'login': (context) => LoginScreen(),
        'register': (context) => RegisterScreen(),
        'payroll': (context) => PayrollScreen(),
        'scheduling': (context) => SchedulingScreen(),
        'chat': (context) => ChatScreen(),
        'settings': (context) => SettingsScreen(),
        'home': (context) => HomeScreen(),
      },
    );
  }
}
