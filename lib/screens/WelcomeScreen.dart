import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task1/WelcomeScreen/Welcome_Screen_1.dart';
import 'package:task1/WelcomeScreen/Welcome_Screen_2.dart';
import 'package:task1/WelcomeScreen/Welcome_Screen_3.dart';
import 'package:task1/screens/Home.dart';

import 'Bottom_navigationBar.dart';
import 'Login.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {

  PageController _controller =PageController();

  bool onLastPage =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.brown.shade200,
        body: Stack(
            children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
            setState(() {
              onLastPage =(index == 2);
            });
            },

            children: [
              WelcomeScreen1(),
              WelcomeScreen2(),
              WelcomeScreen3(),
            ],
          ),

              Container(
                alignment: Alignment(0, 0),
                  child: SmoothPageIndicator(controller: _controller, count: 3,effect: ExpandingDotsEffect(dotColor: Colors.brown.shade400,activeDotColor: Colors.brown,dotHeight: 10,dotWidth: 12),
                  )),


              onLastPage ?
              Container(
                alignment: Alignment(0,0.6),
                child: ElevatedButton(
                  onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Login();
                },));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade100,
                    minimumSize: Size(300, 50),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.brown.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ) :
              Container(
                alignment: Alignment(0,0.6),
                child: ElevatedButton(
                  onPressed: () {
                    _controller.nextPage(duration:Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade100,
                    minimumSize: Size(300, 50),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.brown.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              Container(
                alignment: Alignment(0,0.8),
                child: ElevatedButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade100,
                    minimumSize: Size(300, 50),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        color: Colors.brown.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),

        ])


        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Image.asset(
        //                 'assets/images/Splash_logo_only.png',
        //                 fit: BoxFit.fill,
        //                 width: 80,
        //                 height: 80,
        //               ),
        //       SizedBox(height: 15,),
        //       Text('Welcome to',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
        //       Text('decoze',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
        //       SizedBox(height: 35,),
        //
        //       Text('style your spaces & shop for',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
        //       Text('all your decore needs',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
        //
        //       SizedBox(height: 50,),
        //       ElevatedButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //           Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
        //
        //         },
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.brown.shade50,
        //           minimumSize: Size(280, 50),
        //         ),
        //         child: Text(
        //           'Get Started',
        //           style: TextStyle(
        //               color: Colors.brown.shade500,
        //               fontWeight: FontWeight.bold,
        //               fontSize: 20),
        //         ),
        //       ),],
        //   ),
        // ),
        );
  }
}
