import 'package:flutter/material.dart';

import 'Sign_up.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                      'assets/images/Splash_logo_only.png',
                      fit: BoxFit.fill,
                      width: 80,
                      height: 80,
                    ),
            SizedBox(height: 15,),
            Text('Welcome to',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
            Text('decoze',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
            SizedBox(height: 35,),

            Text('style your spaces & shop for',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
            Text('all your decore needs',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),

            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade50,
                minimumSize: Size(280, 50),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.brown.shade500,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),],
        ),
      ),
    );
  }
}
