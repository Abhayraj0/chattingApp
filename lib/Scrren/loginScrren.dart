import 'package:chattingmessaging/Scrren/forgetPasswordScerren.dart';
import 'package:chattingmessaging/Scrren/homeScrren.dart';
import 'package:chattingmessaging/Scrren/registerScrren.dart';
import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:chattingmessaging/Widget/customeButton.dart';
import 'package:chattingmessaging/Widget/textFiled.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MySignin extends StatefulWidget {
  const MySignin({super.key});

  @override
  State<MySignin> createState() => _MySigninState();
}

class _MySigninState extends State<MySignin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      User? u = userCredential.user;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomeSccren(user: u),
          ));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Successfully Login")));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed Login")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColorsName.backgroundColorA,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In",
                    style: GoogleFonts.maitree(
                        fontSize: 70, color: AllColorsName.textColor),
                  ),
                  MyTextField(
                      iconData: Icons.email,
                      controller: _emailController,
                      lable: "Email",
                      hintText: "Enter the Email"),
                  const SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                      iconData: Icons.password_sharp,
                      controller: _passwordController,
                      lable: "Password",
                      hintText: "Enter the Password"),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyForgotScrren(),
                                ));
                          },
                          child: Text(
                            "Forget Password?",
                            style: GoogleFonts.darumadropOne(
                                fontSize: 25, color: AllColorsName.textColor),
                          )),
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        if (_emailController.text.isEmpty &&
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Pleaase the filed the details")));
                        } else {
                          loginUser();
                          setState(() {
                            _emailController.clear();
                            _passwordController.clear();
                          });
                        }
                      },
                      child: MyCustomeButton(
                          textvalue: "Login", colorname: Colors.purple)),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.aDLaMDisplay(
                            fontSize: 17, color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MySignUpScrren(),
                                ));
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.varta(
                                color: AllColorsName.textColor, fontSize: 20),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
