import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:park_perak_enhancement/constants.dart';
import 'package:park_perak_enhancement/screens/home/home_screen.dart';
import 'package:park_perak_enhancement/screens/login/login_ask_otp_screen.dart';
import 'package:park_perak_enhancement/screens/login/login_email_screen.dart';
import '../register_phone/register_ask_phoneno_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPhoneNoScreen extends StatefulWidget {
  const LoginPhoneNoScreen({Key? key}) : super(key: key);

  @override
  State<LoginPhoneNoScreen> createState() => _LoginPhoneNoScreenState();
}

class _LoginPhoneNoScreenState extends State<LoginPhoneNoScreen> {

  String _number = '';
  String _countryCode = '';

  autoFormatPhoneNumber(String phoneNumber, String countryCode) {
    // Check if the phone number starts with "0"
    if (phoneNumber.startsWith(countryCode)) {
      return phoneNumber;
    } else if (phoneNumber.startsWith(countryCode.substring(1))){
      return countryCode.substring(0,1) + phoneNumber;
    } else if (phoneNumber.startsWith(countryCode.substring(2))){
      return countryCode.substring(0,2) + phoneNumber;
    } else {
      return countryCode + phoneNumber;
    }
  }

  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {

      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    });

    Size size = MediaQuery
        .of(context)
        .size;
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
                child:
                const Image(image: AssetImage('assets/park_perak_logo.png')),
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
                  width: size.width * 0.8,
                  child: IntlPhoneField(
                    style: TextStyle(color: kBlackColor),
                    decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: kGreyColor),
                        filled: true,
                        fillColor: kWhiteColor,
                        hintText: '',
                        hintStyle: TextStyle(color: kGreyColor),
                        errorStyle: TextStyle(color: Colors.red),
                        border: InputBorder.none
                    ),
                    initialCountryCode: 'MY',
                    disableLengthCheck: true,
                    onChanged: (phone) {
                      _number = phone.number;
                      _countryCode = phone.countryCode;
                    },
                  )),
              const SizedBox(
                height: 5,
              ),
              Container(
                  width: size.width * 0.8,
                  height: 40,
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (
                            context) => LoginEmailScreen()),
                      );
                    },
                    child: const Text(
                      'Login with Email',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              Container(
                  width: size.width * 0.8,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        String formattedNumber = autoFormatPhoneNumber(_number, _countryCode);
                        print(formattedNumber);
                        if (formattedNumber.isNotEmpty){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (
                                context) => LoginAskOTPScreen(phone: formattedNumber)),
                          );
                        } else {
                          AlertDialog alert = AlertDialog(
                            title: const Text("Phone Number Missing"),
                            content: const Text(
                                "Please enter your phone number."),
                            actions: [
                              ElevatedButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
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
