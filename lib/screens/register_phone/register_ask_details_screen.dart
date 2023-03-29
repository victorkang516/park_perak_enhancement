import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_perak_enhancement/constants.dart';
import 'package:park_perak_enhancement/screens/home/home_screen.dart';

class RegisterAskDetailsScreen extends StatefulWidget {
  const RegisterAskDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RegisterAskDetailsScreen> createState() =>
      _RegisterAskDetailsScreenState();
}

class _RegisterAskDetailsScreenState extends State<RegisterAskDetailsScreen> {
  FocusNode _firstDigitFocusNode = FocusNode();
  FocusNode _secondDigitFocusNode = FocusNode();
  FocusNode _thirdDigitFocusNode = FocusNode();
  FocusNode _fourthDigitFocusNode = FocusNode();

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  String name = '';
  String emailAddress = '';
  String password = '';
  String confirmPassword = '';

  bool showAlertMessage = false;

  linkMutipleAuth() async {
    final credential =
        EmailAuthProvider.credential(email: emailAddress, password: password);
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
      if (userCredential != null) {
        final user = userCredential.user;
        await user?.updateDisplayName(name);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          AlertDialog alert = AlertDialog(
            title: const Text("Register Error"),
            content:
                const Text("The provider has already been linked to the user."),
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
          break;
        case "invalid-credential":
          AlertDialog alert = AlertDialog(
            title: const Text("Register Error"),
            content: const Text("The provider's credential is not valid."),
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
          break;
        case "credential-already-in-use":
          AlertDialog alert = AlertDialog(
            title: const Text("Register Error"),
            content: const Text(
                "The account corresponding to the credential already exists, or is already linked to a Firebase User."),
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
          break;
        default:
          AlertDialog alert = AlertDialog(
            title: const Text("Register Error"),
            content: const Text(" Unknown error"),
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
          break;
      }
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
                child: const Text('Complete Your Details',
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
                    'Please fill in your name, email and password',
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
                alignment: Alignment.centerLeft,
                height: 60,
                width: size.width * 0.8,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                decoration: BoxDecoration(color: kWhiteColor),
                child: const TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Name',
                      border: InputBorder.none),
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
                      icon: Icon(Icons.lock),
                      hintText: 'Password',
                      border: InputBorder.none),
                  onChanged: (input) {
                    password = input;
                    if (password != confirmPassword) {
                      showAlertMessage = true;
                    } else {
                      showAlertMessage = false;
                    }
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
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Confirm Password',
                      border: InputBorder.none),
                  onChanged: (input) {
                    confirmPassword = input;
                    if (confirmPassword != password) {
                      showAlertMessage = true;
                    } else {
                      showAlertMessage = false;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              showAlertMessage
                  ? Container(
                      height: 24,
                      child: Text(
                        'Confirm Password not matched.',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : const SizedBox(
                      height: 24,
                    ),
              Container(
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {

                    linkMutipleAuth();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  child: const Text(
                    'Complete',
                    style: TextStyle(color: kBlackColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
