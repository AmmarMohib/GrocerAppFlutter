import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groccer_app/Drawer/SignIn/phonenumber.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groccer_app/Home/home.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Transform.translate(
            offset: const Offset(10, 0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromRGBO(0, 0, 0, 1.0), size: 25),
              onPressed: () {
                Navigator.pop(context);
              },
              style: const ButtonStyle(),
            ),
          ),
          title: const Text(
            "Login to the Market Place",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 30),

              // SizedBox(width: 100,),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Let's connect",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 27.5,
                        fontStyle: FontStyle.italic,
                        wordSpacing: 1),
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Image.asset('assets/images/loginImage.png'),
              )),
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text("Login to the Market Place",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.5,
                        color: Colors.black,
                      ))),
              const SizedBox(
                height: 40,
              ),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 30.0),
              //     child: SizedBox(
              //       child: ElevatedButton(
              //           onPressed: () {
              //             Navigator.push(context, MaterialPageRoute(builder: ((context) => PhoneNumberScreen())));
              //           },
              //           child: Row(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(Icons.phone_android_sharp),
              //               SizedBox(
              //                 width: 20,
              //               ),
              //               Text("Continue via number")
              //             ],
              //           ),
              //           style: ElevatedButton.styleFrom(
              //               // backgroundColor: Color.fromRGBO(238, 126, 37, 1.0),
              //               backgroundColor: Color.fromRGBO(128, 160, 186, 1.0),
              //               elevation: 0)),
              //       width: MediaQuery.of(context).size.width * 0.9,
              //       height: MediaQuery.of(context).size.height * 0.065,
              //     ),
              //   ),
              // ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    child: ElevatedButton(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.google),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text("Continue via Google")
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: Color.fromRGBO(238, 126, 37, 1.0),
                            backgroundColor:
                                const Color.fromRGBO(128, 160, 186, 1.0),
                            elevation: 0)),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.065,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const PhoneNumberScreen())));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.appStore),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text("Continue via Apple")
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: Color.fromRGBO(238, 126, 37, 1.0),
                            backgroundColor:
                                const Color.fromRGBO(128, 160, 186, 1.0),
                            elevation: 0)),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.065,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
