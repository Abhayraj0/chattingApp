import 'package:chattingmessaging/Scrren/loginScrren.dart';
import 'package:chattingmessaging/Scrren/messages.dart';
import 'package:chattingmessaging/Scrren/profile.dart';
import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomeSccren extends StatefulWidget {
  User? user;
  MyHomeSccren({super.key, required this.user});

  @override
  State<MyHomeSccren> createState() => _MyHomeSccrenState();
}

class _MyHomeSccrenState extends State<MyHomeSccren> {
  String? name = "";
  Future<void> getUser() async {
    var document = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.user!.uid)
        .get();

    setState(() {
      name = document["Name"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  List<DocumentSnapshot>? mainList;
  List<DocumentSnapshot>? filterList;

  void searchData(String? keyWord) async {
    // DocumentSnapshot allData = await FirebaseFirestore.instance.collection("Abhayraj").doc().get();

    setState(() {
      if (keyWord!.isEmpty) {
        filterList = List.from(mainList!);
      } else {
        filterList = mainList
            ?.where((element) =>
                element['Name'].toLowerCase().contains(keyWord.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection("Users");
    return Container(
        color: AllColorsName.backgroundColorA,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("Hi, $name"),
            iconTheme: IconThemeData(color: AllColorsName.buttonColor),
            actions: [
              PopupMenuButton(
                icon: Icon(Icons.more_vert_sharp),
                onSelected: (value) {
                  if (value == "Profile") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyProfile(
                            user: widget.user,
                          ),
                        ));
                  } else if (value == "LogOut") {
                    print("Logout");

                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MySignin(),
                        ));
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Profile"),
                      value: "Profile",
                    ),
                    PopupMenuItem(
                      child: Text("LogOut"),
                      value: "LogOut",
                    )
                  ];
                },
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(left:30.0,right: 30),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.3),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(2, 7), // changes position of shadow
                      ),
                    ]),
                child: TextFormField(
                  onChanged: (value) {
                    searchData(value);
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      labelText: "Search",
                      hintText: "Type here....",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 65, 40, 70))),
                ),
              ),
              SizedBox(height: 26,),
              Expanded(
                  child: StreamBuilder(
                stream: users.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // var allData = snapshot.data!.docs;
                    mainList = snapshot.data!.docs
                        .where((element) => element.id != widget.user!.uid)
                        .toList();
                    filterList ??= List.from(mainList!);
                    return ListView.builder(
                      itemCount: filterList!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyMessagesScrren(documentSnapshot: filterList![index]),));
                          },
                          child: Card(
                            color: AllColorsName.backgroundColorA,
                            shadowColor: Colors.black,
                            elevation: 30,
                            surfaceTintColor: const Color.fromARGB(255, 56, 104, 128),
                            child: Row(children: [
                              Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                      "${filterList![index]['Profile Url']}")),
                              Text(
                                "${filterList![index]['Name']}",
                                style: GoogleFonts.handjet(fontSize: 30),
                              )
                            ]),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator.adaptive());
                },
              ))
            ]),
          ),
        ));
  }
}
