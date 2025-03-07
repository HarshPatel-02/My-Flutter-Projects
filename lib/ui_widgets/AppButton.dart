

import 'package:flutter/material.dart';

class Appbutton extends StatelessWidget {
  String buttonText;
  var pressAction;
  bool? onlyBorderButton;
  Appbutton({super.key,required this.buttonText,required this.pressAction, this. onlyBorderButton});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: pressAction, 
      color:onlyBorderButton==true?null: Color(0xFFF9FF40),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black38,
          width: 1.5
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      height: 48,
      child: Text(buttonText,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
    );
  }
}
