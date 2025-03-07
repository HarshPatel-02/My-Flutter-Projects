import 'package:flutter/material.dart';

import '../main.dart';

class Extra extends StatelessWidget {
  const Extra({super.key});


  @override
  Widget build(BuildContext context) {

    List<String> values=['https://travelogyindia.b-cdn.net/blog/wp-content/uploads/2014/02/delhi.jpg',
      'https://blog.thomascook.in/wp-content/uploads/2018/04/placestovisitinindiablog.jpg',
      'https://hblimg.mmtcdn.com/content/hubble/img/agra/mmt/activities/m_activities-agra-taj-mahal_l_400_640.jpg',
      'https://www.deccanodysseytrains.com/storage/blog/Humanyuns-Tomb-Delhi.jpg',
];

    return Scaffold(
      body: Center(
      child:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
        
            Container(height: 50),
        
            Center(
              child: ClipRRect
                (child: Image.asset('assets/profile.png',fit: BoxFit.fill,width: 140,height: 140,)
              ,borderRadius: BorderRadius.circular(140),),
              
            ),
            Container(height: 50),
        
        
            Center(  //text field
        
              child: Container(
        
                 //width api textfield ne
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
        
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30)
                          )),
        
                    ),
                    Container(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter Your Mobile Number',
                          border: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(30)
                          )),
        
                    ),
                    Container(height: 10,),
        
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter Your Email',
                          border: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(30)
                          )),
        
                    ),
        
                  ],
        
                ),
        
              ),
            ),
        
            Text(
              'Favorite Place :',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
        
            ),

        GridView.builder(
          //   crossAxisCount: 2,
          // crossAxisSpacing: 4.0,
          // mainAxisSpacing: 4.0,

          itemBuilder: (context, index) =>Image.network(values[index]) ,
          itemCount: values.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 2.0,mainAxisSpacing: 0),
          
          // children :<Widget>[
          //       for(int i=0;i<values.length;i++)
          //
          //   Image.network(values[i]),
          //   //     Image.network(values[1]),
          //   // Image.network(values[2]),
          //   // Image.network(values[3]),


            // ]

        )






        
        
        // GridView(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        //   children: [
        //     for(int i=0;i<5;i++)
        //  Padding(
        //    padding: const EdgeInsets.all(8.0),
        //    child: Image.network('https://hblimg.mmtcdn.com/content/hubble/img/delhi/mmt/activities/m_activities_delhi_red_fort_l_341_817.jpg'),
        //
        //  )
        // ],)


            // TextButton(onPressed: () {
            //   print("Button is Clicked");
            // },
            // child: Text('Click '))
          ],
        ),
      ),
      ),


    );
  }
}
