import 'package:flutter/material.dart';
class WelcomeScreen3 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.purple,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(

                child: Image.asset('assets/images/Screen_3.png',fit: BoxFit.fitHeight,height: 300,)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Discover all the features\n'
                  'decoze has to offer',style: TextStyle(color: Colors.brown,fontSize: 20,fontWeight: FontWeight.bold,),),
               SizedBox(height: 15,),
                Text(
                  textAlign: TextAlign.center,
                  "Dive into decoze's multitude of features by\n"
                  "exploring its diverse functionalities",style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,

                  height: 1.5,

                ),)

              ],
            ),
          ),
        ],
      ),
    );
  }
}
