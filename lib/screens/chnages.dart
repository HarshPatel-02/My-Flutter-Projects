import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class KitchenDetails extends StatefulWidget {
  const KitchenDetails({super.key});

  @override
  State<KitchenDetails> createState() => _KitchenDetailsState();
}

class _KitchenDetailsState extends State<KitchenDetails> {
  double rating = 0;

  List imageList = [
    {"id": 1, "image_path": 'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/WEWB7260STAURUS_LS_1.jpg?tr=w-2732'},
    {"id": 2, "image_path": 'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/bed_WEWB7860STAURUSR2/bed_WEWB7860STAURUSR2_7.jpg?tr=w-2732'},
    {"id": 3, "image_path": 'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/bed_WEWB7860STAURUSR2/bed_WEWB7860STAURUSR2_6.jpg?tr=w-828'},
  ];

  final CarouselSliderController carouselController = CarouselSliderController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height; // Get screen height
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Kitchen', style: TextStyle(fontSize: screenWidth * 0.05)), // Responsive text size
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  print(currentIndex);
                },
                child: Container(
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: screenHeight * 0.3, // Responsive height (30% of screen height)
                  width: double.infinity,
                  child: CarouselSlider(
                    items: imageList.map(
                          (item) => Image.network(
                        item['image_path'],
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ).toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),

              // Dots Indicator for Carousel
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 27 : 10,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: currentIndex == entry.key ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Product Title and Description
              Text(
                'Luxury Double Brown Bed',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05, color: Colors.black),
              ),
              Text(
                'A sleek, minimalist bed with soft white upholstery, built-in LED lighting, and durable hardwood construction. Perfect for adding elegance and ambiance to any modern bedroom.',
                style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black),
              ),
              Divider(color: Colors.black),

              // Price and Favorite/Add to Cart Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ 200.00',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05, color: Colors.black),
                  ),
                  Row(
                    children: [
                      Icon(Iconsax.heart, size: screenWidth * 0.06),
                      SizedBox(width: screenWidth * 0.02),
                      Icon(Iconsax.add_circle, size: screenWidth * 0.06),
                    ],
                  ),
                ],
              ),

              // User Review and Rating Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('User Review', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04)),
                  Row(
                    children: [
                      RatingBar.builder(
                        updateOnDrag: true,
                        itemSize: screenWidth * 0.05, // Responsive rating star size
                        minRating: 1,
                        initialRating: 3,
                        glow: true,
                        glowColor: Colors.yellowAccent,
                        allowHalfRating: false,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2),
                        itemBuilder: (context, index) => Icon(Icons.star, color: Colors.yellowAccent),
                        onRatingUpdate: (rating) => setState(() {
                          this.rating = rating;
                        }),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.1), // Space before button

              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF9FF40),
                    minimumSize: Size(screenWidth * 0.5, screenHeight * 0.06), // Responsive button size
                  ),
                  child: Text(
                    'Add to cart',
                    style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.045),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
