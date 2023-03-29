import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:park_perak_enhancement/constants.dart';
import 'package:park_perak_enhancement/screens/home/home_screen.dart';
import '../register_phone/register_ask_phoneno_screen.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  String emailAddress = '';
  String password = '';
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: const Image(
                    image: AssetImage('assets/park_perak_logo.png')),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                  child: Text(
                'Login',
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                width: size.width * 0.8,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                decoration: BoxDecoration(color: kWhiteColor),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Email',
                      border: InputBorder.none),
                  onChanged: (input) {
                    emailAddress = input;
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                width: size.width * 0.8,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                decoration: BoxDecoration(color: kWhiteColor),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Password', border: InputBorder.none),
                  onChanged: (input) {
                    password = input;
                  },
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                  width: size.width * 0.8,
                  height: 40,
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login with Phone Number',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              Container(
                  width: size.width * 0.8,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailAddress, password: password)
                              .then((value) => Navigator.of(context)
                                  .pushNamedAndRemoveUntil('/home',
                                      (Route<dynamic> route) => false));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: kBlackColor),
                      ))),
              const SizedBox(
                height: 12,
              ),
              Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: kWhiteColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register-ask-number');
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      )
                    ],
                  )),
              Container(
                  height: 40,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  )),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Contact Us',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                    ToggleButtons(
                      children: <Widget>[Text('EN'), Text('BM')],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected,
                      fillColor: kPrimaryColor,
                      selectedColor: kBlackColor,
                      color: kWhiteColor,
                      borderColor: kPrimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
