import 'package:flutter/material.dart';
class WelcomeScreen2 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink.shade100,

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(

                child: Image.asset('assets/images/Screen_21.png',fit: BoxFit.fitHeight,height: 300,)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Stay connected with design team \n'
                   'anytime, anywhere with decoze',style: TextStyle(color: Colors.brown,fontSize: 20,fontWeight: FontWeight.bold,),),
                SizedBox(height: 15,),

                Text(
                  textAlign: TextAlign.center,
                  "In today's dynamic decor world, staying connected\n "
                    'with your design team is key to key to success with\n'
                  'decoze.',style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,

                  // fontSize: 14,
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
