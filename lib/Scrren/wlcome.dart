import 'package:chattingmessaging/Scrren/loginScrren.dart';
import 'package:chattingmessaging/Scrren/registerScrren.dart';
import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:chattingmessaging/Widget/customeButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWlcomeSccreen extends StatefulWidget {
  const MyWlcomeSccreen({super.key});

  @override
  State<MyWlcomeSccreen> createState() => _MyWlcomeSccreenState();
}

class _MyWlcomeSccreenState extends State<MyWlcomeSccreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColorsName.backgroundColorA,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: GoogleFonts.felipa(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: AllColorsName.textColor),
                    ),
                    Text(
                      "Please login or sign up to continue usin our app",
                      style: GoogleFonts.walterTurncoat(fontSize: 20),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/group.png"),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Enter via Social Networks",
                      style: GoogleFonts.sarpanch(
                          fontSize: 25, color: AllColorsName.textColor),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 7,
                                  blurRadius: 9,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                                size: 30,
                              )),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 7,
                                  blurRadius: 9,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.xTwitter,
                                size: 30,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                        child: Text(
                      "or login with \n\t\t\t\t\t email",
                      style: GoogleFonts.finlandica(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 75, 36, 142)),
                    )),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MySignUpScrren(),
                              ));
                        },
                        child: MyCustomeButton(
                            textvalue: "Signup",
                            colorname: AllColorsName.buttonColor)),
                    SizedBox(
                      height: 0,
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
                              "Login",
                              style: GoogleFonts.varta(
                                  color: AllColorsName.textColor, fontSize: 20),
                            ))
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
