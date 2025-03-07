
  import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_rating_bar/flutter_rating_bar.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
  import 'package:task1/screens/Add_To_Cart.dart';

  import '../main.dart';
  import '../models/ProductModel.dart';
  import '../models/dataProvider.dart';

  class ProductDetails extends StatefulWidget {
    var id;

    ProductDetails({super.key, required this.id,});


    @override
    State<ProductDetails> createState() => _ProductDetailsState();
  }

  class _ProductDetailsState extends State<ProductDetails> {
    var product;
    Future<void> SetIntosp(List<ProductItem>cartItems) async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      List<String> cartItemsJson = cartItems.map((item) => jsonEncode(item.toMap())).toList();
      sp.setStringList('cartItems', cartItemsJson);
      print('Saved cartItems: ${cartItems.length}');
    }

    @override
    void initState() {
      product = globalProductList
          .where(
            (element) => element.id == widget.id,
      )
          .toList()
          .first;

      super.initState();
      // getSharedPreferences();

    }
    // late SharedPreferences sp;
    //
    //
    // void saveIntosp() {
    //   List<String> cartItemStore = cartItems.map((e) => jsonEncode(e.toMap())).toList();
    //   sp.setStringList("CartProduct", cartItemStore);
    // }
    //
    // void getIntosp() {
    //   List<String>? cartItemStore = sp.getStringList("CartProduct");
    //   if (cartItemStore != null) {
    //     cartItems = cartItemStore.map((e) => ProductItem.fromMap(jsonDecode(e))).toList();
    //   }
    //   setState(() {
    //
    //   });
    // }
    double rating = 0;

    List imageList = [
      {
        "id": 1,
        "image_path":
        'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/WEWB7260STAURUS_LS_1.jpg?tr=w-2732'
      },
      {
        "id": 2,
        "image_path":
        'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/bed_WEWB7860STAURUSR2/bed_WEWB7860STAURUSR2_7.jpg?tr=w-2732'
      },
      {
        "id": 3,
        "image_path":
        'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/bed_WEWB7860STAURUSR2/bed_WEWB7860STAURUSR2_6.jpg?tr=w-828'
      },
    ];

    final CarouselSliderController carouselController =
    CarouselSliderController();

    int currentIndex = 0;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(product.category),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    print(currentIndex);
                  },
                  child: Container(
                    color: Colors.grey.shade200,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    height: 250,
                    width: double.infinity,
                    child: CarouselSlider(
                        items: imageList
                            .map(
                              (item) =>
                              Image.network(
                                item['image_path'],
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                        )
                            .toList(),
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
                        )),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageList
                      .asMap()
                      .entries
                      .map((entry) {
                    print(entry);
                    print(entry.key);
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(entry.key),
                      child: Container(
                        width: currentIndex == entry.key ? 27 : 10,
                        height: 8,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 3.0,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: currentIndex == entry.key
                                ? Colors.green
                                : Colors.red),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  product.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green),
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25),
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        // Icon(Iconsax.heart),
                        GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                              msg: "Added to Favorites",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                            );
                            setState(() {});
                          },
                          child: Icon(Iconsax.heart),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (product.qty > 1) {
                                product.qty--;
                              }
                            });
                          },
                          child: Icon(Iconsax.minus_cirlce),
                        ),

                        Text(product.qty.toString()),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              product.qty++;
                            });
                          },
                          child: Icon(Iconsax.add_circle),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User Review',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                            itemSize: 18,
                            minRating: 1,
                            initialRating: 3,
                            glow: true,
                            glowColor: Colors.amber,
                            allowHalfRating: false,
                            ignoreGestures: true,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2),
                            itemBuilder: (context, index) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (rating) => setState(() {}))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        // _valueSetter(globalProductList[index]);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => new AddToCart(),
                        //   ),
                        // );
                        if (!cartItems.any((item) => item.id == product.id)) {
                          cartItems.add(product);
                        }
                        SetIntosp(cartItems);


                        print(cartItems.length.toString()+'abc');
                        Fluttertoast.showToast(
                          msg: "Added to Cart",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                        print(cartItems.length.toString() + 'adbbd');
                        setState(() {});
                        print(cartItems.length.toString() + 'adbbd2');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0x4D9B7A5A),
                        minimumSize: Size(250, 50),

                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.black, fontSize: 18),

                      )),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
