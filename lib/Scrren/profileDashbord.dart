import 'dart:io';

import 'package:chattingmessaging/Scrren/profile.dart';
import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileDashBoard extends StatefulWidget {
  User user;
  MyProfileDashBoard({super.key, required this.user});

  @override
  State<MyProfileDashBoard> createState() => _MyProfileDashBoardState();
}

class _MyProfileDashBoardState extends State<MyProfileDashBoard> {
  String? nameU = '';
  String? contactU = '';
  String? aboutU = '';
  var imagePi = '';
  Future<void> getUser() async {
    var document = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.user.uid)
        .get();

    setState(() {
      nameU = document['Name'];
      contactU = document['Contact'];
      aboutU = document["About"];
      imagePi = document["Profile Url"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  File? _pickImage;
  String? _myUsername;
  ImagePicker _picker = ImagePicker();

  void selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickImage = File(pickedFile.path);
        updateProfile();
      });
    } else {
      print("No Image Selected");
      return;
    }
  }

  void captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickImage = File(pickedFile.path);
        updateProfile();
      });
    } else {
      print("No Image Selected");
      return;
    }
  }

  Future<void> updateProfile() async {
    if (_pickImage != null) {
      final _storage = await FirebaseStorage.instance;
      final _ref =
          _storage.ref().child("imagesUser").child(DateTime.now().toString());

      final uploadImage = _ref.putFile(_pickImage!);

      final snapshot = await uploadImage.whenComplete(() => null);

      final d_imageUrl = await snapshot.ref.getDownloadURL();

      User? user = await FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .update({
        "Profile Url": d_imageUrl,
      });
    } else {
      print("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColorsName.backgroundColorA,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.bottomRight,
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    image: _pickImage != null
                        ? DecorationImage(
                            image: FileImage(
                              _pickImage!,
                            ),
                            fit: BoxFit.fill)
                        : DecorationImage(
                            image: NetworkImage(imagePi),fit: BoxFit.fill),
                    border: Border.all(
                        style: BorderStyle.solid,
                        width: 2,
                        color: Colors.black),
                    borderRadius: BorderRadius.circular(200)),
                child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(200)),
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isDismissible: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 250,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Profile photo',
                                        style: GoogleFonts.fanwoodText(
                                            fontSize: 30),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200),
                                                      color: Colors.grey),
                                                  child: InkWell(
                                                      onTap: () {
                                                        captureImage();
                                                        Navigator.of(context).pop();
                                                        // updateProfile();
                                                      },
                                                      child: Icon(
                                                        Icons.camera_alt_sharp,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ))),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                "Camera",
                                                style: GoogleFonts.abel(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200),
                                                      color: Colors.grey),
                                                  child: InkWell(
                                                      onTap: () {
                                                        selectImage();
                                                        Navigator.of(context).pop();

                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .photo_size_select_actual,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ))),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                "Gallery",
                                                style: GoogleFonts.abel(
                                                    fontSize: 20),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ))),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: GoogleFonts.abel(fontSize: 30),
                          ),
                          Text("$nameU",
                              style: GoogleFonts.dancingScript(fontSize: 30)),
                        ],
                      ),
                      Spacer(
                        flex: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyProfile(user: widget.user),
                                ));
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                  Text(
                    "This is not your username or pin.\nThis name will be visible to your \nchatting contact",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 43.0, top: 20),
                child: Divider(
                  thickness: 3,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About",
                        style: GoogleFonts.abel(fontSize: 30),
                      ),
                      Text("$aboutU",
                          style: GoogleFonts.dancingScript(fontSize: 30)),
                    ],
                  ),
                  Spacer(
                    flex: 30,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 43.0, top: 20),
                child: Divider(
                  thickness: 3,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.phone,
                    size: 40,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone",
                        style: GoogleFonts.abel(fontSize: 30),
                      ),
                      Text("$contactU",
                          style: GoogleFonts.dancingScript(fontSize: 30)),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
