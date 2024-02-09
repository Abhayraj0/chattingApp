import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:chattingmessaging/Widget/customeButton.dart';
import 'package:chattingmessaging/Widget/textFiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyForgotScrren extends StatefulWidget {
  const MyForgotScrren({super.key});

  @override
  State<MyForgotScrren> createState() => _MyForgotScrrenState();
}

class _MyForgotScrrenState extends State<MyForgotScrren> {
  TextEditingController _emailController = TextEditingController();
  Future<void> resetPass(String? email) async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);

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
                                "\t\tForget Password",
                                style: GoogleFonts.maitree(
                                    fontSize: 70,
                                    color: AllColorsName.textColor),
                              ),
                              MyTextField(
                                  iconData: Icons.email,
                                  controller: _emailController,
                                  lable: "Email",
                                  hintText: "Enter the Email"),
                              SizedBox(
                                height: 25,
                              ),
                              InkWell(onTap: () {
                                resetPass(_emailController.text.toString());
                              },child: MyCustomeButton(textvalue: "Send", colorname: AllColorsName.buttonColor))
                            ]))))));
  }
}
