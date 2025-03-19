import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task1/screens/Home.dart';
import 'package:task1/screens/WelcomeScreen.dart';

import 'Bottom_navigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(
              builder: (context) => Welcomescreen(),
            )
        );
    });

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.brown.shade200,
      body: Container(child: Center(child: Image.asset('assets/images/Splash_logo.png',fit: BoxFit.fill,width: 140,height: 140,)),),
      // body:
      // Container(
      //   // color: Colors.black,
      //   child: Center(child: Text('Splash',style: TextStyle(
      //     fontSize: 34,
      //     fontWeight: FontWeight.w700,
      //     color: Colors.white,
      //   ),
      //   ) ,
      //   ),
      // )

    );
  }
}
