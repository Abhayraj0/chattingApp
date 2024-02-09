import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyMessagesScrren extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  MyMessagesScrren({super.key, required this.documentSnapshot});

  @override
  State<MyMessagesScrren> createState() => _MyMessagesScrrenState();
}

class _MyMessagesScrrenState extends State<MyMessagesScrren> {

  TextEditingController _messagesController = TextEditingController();

  Future<void> sedMessage() async {
    await FirebaseFirestore.instance.collection("MessageUser").add({
      "Sender" : FirebaseAuth.instance.currentUser!.uid,
      "Receiver" : widget.documentSnapshot.id,
      "Message" : _messagesController.text.toString(),
      "Timestamp" : DateTime.now()
    });
    setState(() {
      _messagesController.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //seder Id get
    print("Sender Id : ${FirebaseAuth.instance.currentUser}");
    // receiver Id get
    print("Receiver Id : ${widget.documentSnapshot.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColorsName.backgroundColorA,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.documentSnapshot["Name"]}"),
        ),
        backgroundColor: Colors.transparent,
        body: Column(children: [
          Expanded(
            child: StreamBuilder(stream: FirebaseFirestore.instance.collection("MessageUser")
            .where("Receiver", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("Sender", isEqualTo: widget.documentSnapshot.id)
            .snapshots() ,builder: (context, senderSnapshot) {
              if (senderSnapshot.hasData) {
                var senderMessager = senderSnapshot.data!.docs;
                return StreamBuilder(stream: FirebaseFirestore.instance.collection("MessageUser")
                .where("Receiver",isEqualTo: widget.documentSnapshot.id)
                .where("Sender", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(), builder: (context, receiverSnapshot) {
                  if (receiverSnapshot.hasData) {
                    var receiverMessager = receiverSnapshot.data!.docs;
                  }
                  return Center(child: CircularProgressIndicator());
                },);
              } return Center(child: Center(child: CircularProgressIndicator()));
            },)
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messagesController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Type here message...."
                    ),
                  ),
                ),
                IconButton(onPressed: () {
                  sedMessage();
                }, icon: Icon(Icons.send))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
