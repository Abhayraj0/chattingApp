
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyCustomeButton extends StatelessWidget {
  String? textvalue;
  Color? colorname;
   MyCustomeButton({super.key,required this.textvalue,
    required this.colorname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        child: Center(child: Text("$textvalue",style: GoogleFonts.novaRound(fontSize: 30,color: Colors.white),)),
        decoration: BoxDecoration(
          color: colorname,
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}