import 'package:flutter/material.dart';
class WelcomeScreen1 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(

                child: Image.asset('assets/images/Screen_1.png',fit: BoxFit.fitHeight,height: 300,)),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Effortlessly organize your decor\n'
                      'and shopping with decoze ',
                  style: TextStyle(color: Colors.brown,fontSize: 20,fontWeight: FontWeight.bold,),),
                SizedBox(height: 15,),

                Text(
                  'Confidently navigate your decor journey, ensuring a\n'
                      'stylish and productive path to your dream space\n'
                      'with decoze',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.brown,
                    // fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),



              ],
            ),
          ),
        ],
      ),

    );
  }
}
