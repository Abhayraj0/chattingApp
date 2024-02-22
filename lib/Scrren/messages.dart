import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyMessagesScrren extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  MyMessagesScrren({super.key, required this.documentSnapshot});

  @override
  State<MyMessagesScrren> createState() => _MyMessagesScrrenState();
}

class _MyMessagesScrrenState extends State<MyMessagesScrren> {
  TextEditingController _messagesController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  Future<void> sedMessage() async {
    await FirebaseFirestore.instance.collection("MessageUser").add({
      "Sender": FirebaseAuth.instance.currentUser!.uid,
      "Receiver": widget.documentSnapshot.id,
      "Message": _messagesController.text.toString(),
      "Timestamp": DateTime.now()
    });

    setState(() {
      _messagesController.clear();
    });
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: AllColorsName.backgroundColorA,
        child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.documentSnapshot["Name"]}"),
            leading: Flex(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                Flexible(
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                widget.documentSnapshot['Profile Url']),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(200)),
                  ),
                )
              ],
              direction: Axis.horizontal,
            ),
            backgroundColor: Colors.blueGrey,
          ),
          backgroundColor: Colors.transparent,
          body: Column(children: [
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("MessageUser")
                  .where("Receiver",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where("Sender", isEqualTo: widget.documentSnapshot.id)
                  .snapshots(),
              builder: (context, senderSnapshot) {
                if (senderSnapshot.hasData) {
                  var senderMessager = senderSnapshot.data!.docs;
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("MessageUser")
                        .where("Receiver",
                            isEqualTo: widget.documentSnapshot.id)
                        .where("Sender",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, receiverSnapshot) {
                      if (receiverSnapshot.hasData) {
                        var receiverMessager = receiverSnapshot.data!.docs;

                        var allMessages = senderMessager + receiverMessager;
                        // var allMessages = [...senderMessager, ...receiverMessager];
                        allMessages.sort(
                          (a, b) => (a['Timestamp'] as Timestamp)
                              .compareTo(b['Timestamp'] as Timestamp),
                        );
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: allMessages.length + 1,
                          itemBuilder: (context, index) {
                            if (index == allMessages.length) {
                              return SizedBox(
                                height: 10,
                              );
                            }
                            var message = allMessages[index];
                            String senderID = message['Sender'];
                            bool isCurrentUserIsSender = senderID ==
                                FirebaseAuth.instance.currentUser!.uid;

                            return Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: isCurrentUserIsSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  if (!isCurrentUserIsSender)
                                    Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      widget.documentSnapshot[
                                                          'Profile Url']),
                                                  fit: BoxFit.fill),
                                              borderRadius:
                                                  BorderRadius.circular(200)),
                                        ),
                                      ],
                                    )
                                  else
                                    SizedBox(
                                      width: 40,
                                    ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          message['Message'],
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 15,color: Colors.black),
                                        ),
                                        Text(
                                          DateFormat('HH:mm a').format(
                                              message['Timestamp'].toDate()),
                                          style: GoogleFonts.aDLaMDisplay(
                                              fontSize: 10,color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                }
                return Center(
                    child: Center(child: CircularProgressIndicator()));
              },
            )),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messagesController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      onSubmitted: (value) {
                        // Manually insert a newline character when Enter key is pressed
                        _messagesController.text += '\n';
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Type here message...."),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        sedMessage();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
