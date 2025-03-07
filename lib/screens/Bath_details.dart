import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';



class BathDetails extends StatefulWidget {
  const BathDetails({super.key});

  @override
  State<BathDetails> createState() => _BathDetailsState();
}

class _BathDetailsState extends State<BathDetails> {
  double rating =0;

  List imageList=[
    {"id":1,"image_path":'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/WEWB7260STAURUS_LS_1.jpg?tr=w-2732'},
    {"id":2,"image_path":'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/bed_WEWB7860STAURUSR2/bed_WEWB7860STAURUSR2_7.jpg?tr=w-2732'},
    {"id":3,"image_path":'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/bed_WEWB7860STAURUSR2/bed_WEWB7860STAURUSR2_6.jpg?tr=w-828'},
  ];

  final CarouselSliderController  carouselController = CarouselSliderController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bath'),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell( onTap: (){
                print(currentIndex);
              },
                child: Container(
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 200 ,
                  width: double.infinity,
                  child: CarouselSlider(items: imageList
                      .map(
                        (item) => Image.network(
                      item['image_path'],
                      fit: BoxFit.contain,
                      width: double.infinity,

                    ),)

                      .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index,reason){
                          setState(() {
                            currentIndex =index;
                          });

                        },
                      )),
                ),
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children:
                imageList.asMap().entries.map((entry){
                  print(entry);
                  print(entry.key);
                  return GestureDetector(
                    onTap: () =>  carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 27 : 10,
                      height: 8,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: currentIndex == entry.key
                              ? Colors.green : Colors.red
                      ),
                    ),

                  );
                }).toList(),
              ),
              Text('Luxury Double Brown Bed',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
              Text('A sleek, minimalist bed with soft white upholstery, built-in LED lighting, and durable hardwood construction. Perfect for adding elegance and ambiance to any modern bedroom.',style: TextStyle(fontSize: 15,color: Colors.black),),
              Divider(
                  color: Colors.black
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$ 200.00',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                  Row(
                    children: [
                      Icon(Iconsax.heart),
                      Icon(Iconsax.add_circle),
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('User Review',style: TextStyle(color: Colors.black,fontSize: 12),),
                  Row(
                    children: [
                      RatingBar.builder(updateOnDrag: true,
                          itemSize: 18,
                          minRating: 1,initialRating: 3,glow: true,glowColor: Colors.yellowAccent,allowHalfRating: false,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2 ),
                          itemBuilder: (context, index) =>
                              Icon(Icons.star,color: Colors.yellowAccent,)
                          , onRatingUpdate: (rating) => setState(() {
                            this.rating=rating;
                          }))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 250,),
              Center(

                child: ElevatedButton(onPressed: () {

                },
                    style: ElevatedButton.styleFrom(

                      backgroundColor: Color(0xFFF9FF40),
                      minimumSize: Size(200, 50),

                    ),

                    child: Text('Add to cart',style: TextStyle(color: Colors.black),)),
              )            ],
          ),
        ),

      ),
    );
  }
}


