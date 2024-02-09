import 'package:flutter/material.dart';

// class MyTextField extends StatelessWidget {
  
//   IconData? iconData1;
//   MyTextField(
//       {

//       this.iconData1});

//   @override
//   Widget build(BuildContext context) {
   
//   }
// }

class MyTextField extends StatefulWidget {
  TextEditingController? controller;
  String? lable;
  String? hintText;
  IconData? iconData;
   MyTextField({super.key,required this.controller,
      required this.lable,
      required this.hintText,
      required this.iconData,});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
     return  Container(
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
          obscureText: widget.lable == "Password" ? obscureText : false,
          controller: widget.controller,
      
          style: TextStyle(color: Colors.black),
          readOnly: widget.lable == "User Email" ? true : false,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(widget.iconData),
              suffixIcon: widget.lable == "Password" ? IconButton(onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              }, icon: Icon( !obscureText ? Icons.visibility_sharp : Icons.visibility_off_sharp)) : null,
              labelText: widget.lable,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Color.fromARGB(255, 65, 40, 70))),
        ),
      
    );
  }
}