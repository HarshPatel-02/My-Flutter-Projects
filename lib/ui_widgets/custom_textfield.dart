import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  IconData? icon;


   CustomTextfield({super.key,required this.hintText,required this.controller,this.icon});


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.brown.shade200,width: 1.6),borderRadius: BorderRadius.circular(32)),
        suffixIcon:icon != null? IconButton(
                icon: Icon(icon), onPressed: () {  },
              ):null,
        hintText: hintText,
        // suffixIcon: icon != null?IconButton(icon: Icon(icon) ,):null,
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32),borderSide: BorderSide(color: Colors.brown.shade500,width: 1.6)
        ),
      ),
    );
  }
}
