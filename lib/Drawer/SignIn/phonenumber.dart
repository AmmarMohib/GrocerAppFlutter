import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groccer_app/Drawer/SignIn/sms.dart';
import 'package:groccer_app/Home/home.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool otpVisibility = false;

  String verificationID = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 80),
                child: Text(
                  "Enter your mobile number",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 20),
                child: Text(
                  "Enter your number to create an account or login",
                  style: TextStyle(
                      fontSize: 19,
                      color: Color.fromRGBO(92, 90, 90, 1),
                      fontWeight: FontWeight.w300),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      prefix: Text("", style: TextStyle(fontSize: 20)),
                      // focusColor: Colors.amber
                      // border: border,
                      // hintText: 'Enter a search term',
                    ),
                  ),
                ),
              ),
              Visibility(
                child: TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                    hintText: 'OTP',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(''),
                    ),
                  ),
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                ),
                visible: otpVisibility,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                    child: ElevatedButton(
                        onPressed: () async {
                          // Navigator.push(context, MaterialPageRoute(builder: ((context) => SmsVerifyScreen())));
                          if (otpVisibility == false) {
                            auth.verifyPhoneNumber(
                              phoneNumber: phoneController.text,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) async {
                                await auth
                                    .signInWithCredential(credential)
                                    .then((value) {
                                  print("You are logged in successfully");
                                });
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PhoneNumberScreen()));
                                print(e.message);
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                otpVisibility = true;
                                verificationID = verificationId;
                                setState(() {});
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
                                print(verificationId);
                              },
                            );
                          } else {
                            verifyOTP();
                          }
                          // Fluttertoast.showToast(
                          //     msg: 'Wait for a while, so the app will send you verification code',
                          //     fontSize: 20,
                          //     backgroundColor: Colors.green);
                        },
                        child: Text(
                          "Login/Sign up",
                          style: TextStyle(fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(238, 126, 37, 1.0),
                            elevation: 0)),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);
    await auth.signInWithCredential(credential).then(
      (value) {
        print("You are logged in successfully");
        // Fluttertoast.showToast(
        //   msg: "You are logged in successfully",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.red,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      },
    ).whenComplete(
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      },
    );
  }
}
