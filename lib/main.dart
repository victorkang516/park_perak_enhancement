import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_perak_enhancement/screens/home/home_screen.dart';
import 'package:park_perak_enhancement/screens/login/login_phoneno_screen.dart';
import 'package:park_perak_enhancement/screens/register_phone/register_ask_phoneno_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      routes: {
        '/': (context) => HomeScreen(),
        '/register-ask-number': (context) => RegisterAskPhoneNoScreen(),
        '/home': (context) => HomeScreen()
      },
    );
  }
}