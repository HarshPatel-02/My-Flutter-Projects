import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String containerText; // Correct variable declaration

  // Proper constructor
  const CustomContainer({Key? key, required this.containerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Center(
        child: Text(
          containerText,
          style: TextStyle(color: Colors.white), // Optional styling
        ),

      ),
    );
  }
}
