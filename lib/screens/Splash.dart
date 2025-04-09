import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/screens/Home.dart';
import 'package:task1/screens/Login.dart';
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

    Timer(Duration(seconds: 3), ()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasSeenWelcome = prefs.getBool('hasSeenWelcome') ?? false;
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationbar()),
        );
      }
      else if (hasSeenWelcome) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        // If the user hasn't seen the welcome screen, show the WelcomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Welcomescreen()),
        );
      };
      // Navigator.pushReplacement(context,
      //       MaterialPageRoute(
      //         builder: (context) => Welcomescreen(),
      //       )
      //   );
    });

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.brown.shade200,
      body: Container(child: Center(child: Image.asset('assets/images/Splash_2.png',fit: BoxFit.fill,width: 280,height: 280,)),),
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
