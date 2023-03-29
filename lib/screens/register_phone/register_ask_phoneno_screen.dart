import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:park_perak_enhancement/constants.dart';
import 'package:park_perak_enhancement/screens/register_phone/register_ask_otp_screen.dart';

class RegisterAskPhoneNoScreen extends StatefulWidget {
  const RegisterAskPhoneNoScreen({Key? key}) : super(key: key);

  @override
  State<RegisterAskPhoneNoScreen> createState() =>
      _RegisterAskPhoneNoScreenState();
}

class _RegisterAskPhoneNoScreenState extends State<RegisterAskPhoneNoScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

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
            children: [
              Container(
                width: size.width * 0.85,
                alignment: Alignment.centerLeft,
                child: const Image(
                  image: AssetImage('assets/park_perak_logo.png'),
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.8,
                child: const Text('Register',
                    style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width * 0.8,
                child: const Text(
                    'Enter your mobile number below. You’ll receive an SMS with a OTP.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal)),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: size.width * 0.8,
                child: const Text('Mobile number',
                    style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal)),
              ),
              const SizedBox(
                height: 12,
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
                        border: InputBorder.none),
                    initialCountryCode: 'MY',
                    disableLengthCheck: true,
                    onChanged: (phone) {
                      _number = phone.number;
                      _countryCode = phone.countryCode;
                    },
                  )),
              const SizedBox(
                height: 64,
              ),
              Container(
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () async {
                    String formattedNumber = autoFormatPhoneNumber(_number, _countryCode);
                    print(formattedNumber);
                    if (formattedNumber.isNotEmpty){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (
                            context) => RegisterAskOTPScreen(phone: formattedNumber)),
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
                  child: Text(
                    'Continue',
                    style: TextStyle(color: kBlackColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                  height: 40,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'I would like to use Email to Sign Up',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  )),
              Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: kWhiteColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () async {},
                        child: const Text(
                          'Login',
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
            ],
          ),
        ),
      ),
    );
  }
}
