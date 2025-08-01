
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/screens/Add_To_Cart.dart';

import '../dataBase/DataBaseHelperClass.dart';
import '../main.dart';
import '../models/ProductModel.dart';
import '../models/dataProvider.dart';

class ProductDetails extends StatefulWidget {
  final int id;
  double rating = 0;
  late ProductItem product;

  ProductDetails({super.key, required this.id,});


  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var product;


  final DataBaseHelper dbHelper = DataBaseHelper.instance;
  @override
  void initState() {
    product = globalProductList
        .where(
          (element) => element.id == widget.id,
    )
        .toList()
        .first;

    product.qty=1;

    super.initState();
    loadFavorites();
    _loadCartItems();
  }

  void loadFavorites() async {
    int userId = 1;
    favoriteProducts = await dbHelper.getFavItems(userId); // Fetch from SQLite
    setState(() {}); // Update UI
  }

  Future<void> _loadCartItems() async {
    try {
      int userId = 1;
      cartItems = await dbHelper.getCartItems(userId);

      setState(() {});
    } catch (e) {
      print("Error loading cart items: $e");
    }
  }


  Future<void> _removeItem(int index) async {
    try {
      await dbHelper.removeFromFav(favoriteProducts[index].id);
       // Refresh the list
    } catch (e) {
      print("Error removing item: $e");
    }
  }Future<void> _removeCartItem(int index) async {
    try {
      await dbHelper.removeFromFav(favoriteProducts[index].id);
       // Refresh the list
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  Future<void> _updateQuantity(int index, int newQty) async {
    if (newQty < 1) {
      await _removeCartItem(index);
      return;
    }

    try {
      cartItems[index].qty = newQty;
      await dbHelper.updateCartItem(cartItems[index]);

      setState(() {});
    } catch (e) {
      print("Error updating quantity: $e");
    }
  }


  // List imageList = [
  //   {
  //     "id": 1,
  //     "image_path":
  //     'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/WEWB7260STAURUS_LS_1.jpg?tr=w-2732'
  //   },
  //   {
  //     "id": 2,
  //     "image_path":
  //     'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/bed_WEWB7860STAURUSR2/bed_WEWB7860STAURUSR2_7.jpg?tr=w-2732'
  //   },
  //   {
  //     "id": 3,
  //     "image_path":
  //     'https://ik.imagekit.io/2xkwa8s1i/img/npl_modified_images/EW_Beds_New/bed_WEWB7860STAURUSR2/bed_WEWB7860STAURUSR2_6.jpg?tr=w-828'
  //   },
  // ];

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
                  // print(currentIndex);
                },
                child: Container(
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 350,
                  width: 500,
                  child: CarouselSlider(
                      items:
                          [
                            for(int i=0;i<product.img.length;i++)
                      Image.asset(
                              product.img[i],
                              fit: BoxFit.fill,
                              width: double.infinity,
                              // height: double.infinity,
                            ),

                          ],

                      // product.img
                      //     .map(
                      //       (item) =>
                      //       Image.network(
                      //         item,
                      //         fit: BoxFit.contain,
                      //         width: double.infinity,
                      //
                      //       ),
                      // )
                      //     .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2/3,
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
                children: product.img
                    .asMap()
                    .entries
                    .map<Widget>((entry) {
                  // print(entry);
                  // print(entry.key);
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
                              ? Colors.brown.shade500
                              : Colors.brown.shade200),
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
                    spacing: 8,
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
                        child: IconButton(
                          onPressed: () async {
                            bool isFavorite = favoriteProducts.any((item) => item.id == product.id);

                            if (isFavorite) {
                              await dbHelper.removeFromFav(product.id);
                              favoriteProducts.removeWhere((item) => item.id == product.id);
                              Fluttertoast.showToast(msg: 'Favorite Removed', backgroundColor: Colors.red);
                            } else {
                              int userId = 1;
                              await dbHelper.addToFav(product,userId);
                              favoriteProducts.add(product);
                              Fluttertoast.showToast(msg: 'Favorite Added', backgroundColor: Colors.green);
                            }

                            setState(() {});
                          },
                          icon: Icon(
                            favoriteProducts.any((item) => item.id == product.id) ? Icons.favorite : Icons.favorite_border,
                            color: favoriteProducts.any((item) => item.id == product.id) ? Colors.red : Colors.brown,
                          ),
                          tooltip: 'Favorite',
                          iconSize: 24,
                        )


                      ),

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
                height: 60,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async{
                      // await dbHelper.addToCart(product);
                      // _valueSetter(globalProductList[index]);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  AddToCart(),
                        ),
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade100,
                      minimumSize: Size(250, 50),
                    ),

                    child: Text(
                      'View to Cart',
                      style: TextStyle(color: Colors.brown.shade700,fontWeight: FontWeight.bold ,fontSize: 18),

                    )),

              ),
              SizedBox(
                height: 20,
              ),

              Center(
                child: ElevatedButton(
                    onPressed: () async{
                      int userId = 1;
                      print("CheckProductID::::${product.id}");
                      print("CheckProductID:::cartItems:${cartItems.map((e) => e.id,).toList()}");
                      // if(
                      // cartItems.map((e) => e.id,).toList().contains(product.id)){
                      //   return;
                      // }

                      if (!cartItems.any((item) => item.id == product.id)) {
                        // cartItems.add(product);
                        await dbHelper.addToCart(product,userId);
                        print(cartItems.length.toString()+'abc');
                        Fluttertoast.showToast(
                          msg: "Added to Cart",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                      }
                      else{
                        int alredyItem = cartItems.indexWhere((item) => item.id == product.id);
                        int currentQty = cartItems[alredyItem].qty;
                        await _updateQuantity(alredyItem, currentQty + 1);
                        print(cartItems.length.toString()+'abc');
                        Fluttertoast.showToast(
                          msg: "Quantity increase in cart",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                      }
                      // print('-----PRODUCTID---${product}');
                      // await dbHelper.addToCart(product, userId);
                      print('-----${cartItems.length}');
                      for(int i = 0; i<cartItems.length; i++){
                        print('----CART ITEM ----${cartItems[i]}');
                      }

                      print(cartItems.length.toString() + 'adbbd');
                      setState(() {});

                      print(cartItems.length.toString() + 'adbbd2');
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade100,
                      minimumSize: Size(250, 50),
                    ),

                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.brown.shade700,fontWeight: FontWeight.bold ,fontSize: 18),

                    )),

              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),

      ),
    );
  }
}
