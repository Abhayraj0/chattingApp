import 'package:chattingmessaging/Scrren/homeScrren.dart';
import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:chattingmessaging/Widget/customeButton.dart';
import 'package:chattingmessaging/Widget/textFiled.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfile extends StatefulWidget {
  User? user;
  MyProfile({super.key, required this.user});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  Future<void> updateUser(String? name, about, email) async {
    User? user = await FirebaseAuth.instance.currentUser;
    // user!.updateEmail(email);

    await FirebaseFirestore.instance.collection("Users").doc(widget.user!.uid).update({
      "Name" : name,
      "About" : about,
      "Email" : email
    });
  }

  Future<void> getUser() async {
    var document = await FirebaseFirestore.instance.collection("Users").doc(widget.user!.uid).get();

    setState(() {
      _nameController.text = document['Name'];
      _aboutController.text = document['About'];
      _emailController.text = document['Email'];

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: Column(children: [
              Center(
                child: Text(
                  "Edit Profile",
                  style: GoogleFonts.habibi(fontSize: 40),
                ),
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
                        iconData: Icons.info,
                        controller: _aboutController,
                        lable: "About Information",
                        hintText: "Enter the About Information"),
                    
                    SizedBox(
                      height: 25,
                    ),
              InkWell(
                onTap: () {
                  updateUser(_nameController.text.toString(), _aboutController.text.toString(), _emailController.text.toString());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomeSccren(user: widget.user),));
                },
                  child: MyCustomeButton(
                      textvalue: "Update",
                      colorname: AllColorsName.buttonColor))
            ]),
          ),
        ),
      ),
    );
  }
}