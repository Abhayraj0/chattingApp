import 'package:chattingmessaging/Widget/Color/colorEx.dart';
import 'package:flutter/material.dart';

class MyProfileDashBoard extends StatefulWidget {
  const MyProfileDashBoard({super.key});

  @override
  State<MyProfileDashBoard> createState() => _MyProfileDashBoardState();
}

class _MyProfileDashBoardState extends State<MyProfileDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColorsName.backgroundColorA,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent,),
        body: Stack(alignment: Alignment.bottomRight, children: [
          CircleAvatar(
            radius: 130,
            backgroundImage: AssetImage('assets/images/group.png'),
          ),
          Container(,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.add,size: 40,color: Colors.black,)))
        ]),
      ),
    );
  }
}
