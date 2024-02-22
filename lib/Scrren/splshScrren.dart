import 'dart:async';

import 'package:chattingmessaging/Scrren/loginScrren.dart';
import 'package:chattingmessaging/Scrren/wlcome.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MySplshScrren extends StatefulWidget {
  const MySplshScrren({super.key});

  @override
  State<MySplshScrren> createState() => _MySplshScrrenState();
}

class _MySplshScrrenState extends State<MySplshScrren> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSplashScrren();
  }
  Future<void> getSplashScrren() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MySignin(),
        ));
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Lottie.network(
              'https://lottie.host/e3a2039f-1e9f-497e-9c3e-99556850aa28/KVBddK9at8.json',
              fit: BoxFit.fill,
              height: 500,
              width: 500,
              reverse: true,
              repeat: true)
        ]),
      ),
    );
  }
}
