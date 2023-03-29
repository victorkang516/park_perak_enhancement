import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_perak_enhancement/constants.dart';
import 'package:park_perak_enhancement/screens/register_phone/register_ask_details_screen.dart';

class RegisterAskOTPScreen extends StatefulWidget {
  final String phone;

  RegisterAskOTPScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<RegisterAskOTPScreen> createState() => _RegisterAskOTPScreenState();
}

class _RegisterAskOTPScreenState extends State<RegisterAskOTPScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  var _verificationId = '';

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  FocusNode _focusNode5 = FocusNode();
  FocusNode _focusNode6 = FocusNode();

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => verifyPhoneNumber(context));
  }

  verifyPhoneNumber(context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth
            .signInWithCredential(credential)
            .whenComplete(() => {print('Completed')});
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          AlertDialog alert = AlertDialog(
            title: Text("Invalid Phone Number"),
            content: Text(
                "You have entered an invalid phone number. Please try again."),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).popUntil((route) {
                    if (route.settings.name == '/register-ask-number') {
                      return true;
                    }
                    return false;
                  });
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
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          _verificationId = verificationId;
        });
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
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
                child: Image(
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
                child: Text(
                    'We’ve sent a OTP to ${widget.phone}. Please enter the number below.',
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
                child: Text('OTP',
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
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _controller1,
                        focusNode: _focusNode1,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kWhiteColor,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode1.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode2);
                          } else if (value.isEmpty) {
                            _focusNode1.unfocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _controller2,
                        focusNode: _focusNode2,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kWhiteColor,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode2.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode3);
                          } else if (value.isEmpty) {
                            _focusNode2.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode1);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _controller3,
                        focusNode: _focusNode3,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kWhiteColor,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode3.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode4);
                          } else if (value.isEmpty) {
                            _focusNode3.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode2);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _controller4,
                        focusNode: _focusNode4,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kWhiteColor,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode4.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode5);
                          } else if (value.isEmpty) {
                            _focusNode4.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode3);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _controller5,
                        focusNode: _focusNode5,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kWhiteColor,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode5.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode6);
                          } else if (value.isEmpty) {
                            _focusNode5.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode4);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _controller6,
                        focusNode: _focusNode6,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kWhiteColor,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            _focusNode6.unfocus();
                          } else if (value.isEmpty) {
                            _focusNode6.unfocus();
                            FocusScope.of(context).requestFocus(_focusNode5);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 64,
              ),
              Container(
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () async {
                    var smsCode = _controller1.text +
                        _controller2.text +
                        _controller3.text +
                        _controller4.text +
                        _controller5.text +
                        _controller6.text;
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationId,
                              smsCode: smsCode))
                          .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterAskDetailsScreen()),
                              ));
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: kBlackColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
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
