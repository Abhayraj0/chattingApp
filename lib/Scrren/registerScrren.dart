import 'package:chattingmessaging/Scrren/homeScrren.dart';
import 'package:chattingmessaging/Scrren/loginScrren.dart';
import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:chattingmessaging/Widget/customeButton.dart';
import 'package:chattingmessaging/Widget/textFiled.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MySignUpScrren extends StatefulWidget {
  const MySignUpScrren({super.key});

  @override
  State<MySignUpScrren> createState() => _MySignUpScrrenState();
}

class _MySignUpScrrenState extends State<MySignUpScrren> {
  String? profilePicUrl =
      "https://cdn3d.iconscout.com/3d/premium/thumb/profile-8260859-6581822.png?f=webp";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser(
      String? name, contact, email, password, profileUrl) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    await FirebaseFirestore.instance.collection("Users").doc(user!.uid).set({
      "Name": name,
      "Contact": contact,
      "Email": email,
      "Password": password,
      "Profile Url": profilePicUrl
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomeSccren(user: user),
        ));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Successfully Register")));
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
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: GoogleFonts.maitree(
                        fontSize: 70, color: AllColorsName.textColor),
                  ),
                  Image.network(
                    "$profilePicUrl",
                    height: 150,
                    width: 150,
                  ),
                  MyTextField(
                      iconData: Icons.person,
                      controller: _nameController,
                      lable: "UserName",
                      hintText: "Enter the userName"),
                  SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                      iconData: Icons.contact_phone,
                      controller: _contactController,
                      lable: "Contact",
                      hintText: "Enter the Contact"),
                  SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                      iconData: Icons.email,
                      controller: _emailController,
                      lable: "Email",
                      hintText: "Enter the Email"),
                  SizedBox(
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
                  InkWell(
                      onTap: () async {
                        if (_nameController.text.isEmpty &&
                            _contactController.text.isEmpty &&
                            _emailController.text.isEmpty &&
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please filled the details")));
                        } else {
                           await registerUser(
                              _nameController.text,
                              _contactController.text,
                              _emailController.text,
                              _passwordController.text,
                              _passwordController.text);
                          setState(() {
                            _nameController.clear();
                            _contactController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                          });
                        }
                      },
                      child: MyCustomeButton(
                          textvalue: "Register", colorname: AllColorsName.buttonColor)),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You already have an account?",
                        style: GoogleFonts.aDLaMDisplay(
                            fontSize: 17, color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MySignin(),
                                ));
                          },
                          child: Text(
                            "Sign In",
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
