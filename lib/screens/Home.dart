import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:task1/main.dart';
import 'package:task1/screens/Favourite.dart';
import 'package:task1/screens/Search.dart';

import '../ProductModel.dart';
import '../dataBase/DataBaseHelperClass.dart';
import '../models/ProductModel.dart';
import '../models/dataProvider.dart';
import 'Product_details.dart';

class Home extends StatefulWidget {
  var tabChange;
  Home({super.key, required this.tabChange});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DataBaseHelper dbHelper = DataBaseHelper.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFavItems();
  }
  Future<void> _loadFavItems() async {
    try {
      int userId = 1;
      favoriteProducts = await dbHelper.getFavItems(userId);
      setState(() {});
    } catch (e) {
      print("Error loading cart items: $e");
    }
  }

  void _onRemoveFromFavorites(ProductItem product) {
    setState(() {
      Fluttertoast.showToast(msg: 'Remove favorite');
      favoriteProducts.remove(product);
    });
  }

  List imageList = [
    {"id": 1, "image_path": 'assets/images/sofa1.jpeg'},
    {"id": 2, "image_path": 'assets/images/sofa2.jpeg'},
    {"id": 3, "image_path": 'assets/images/sofa1.jpeg'},
  ];
  List<Category>? categoryList = [
    Category(
        category: "Bedroom",
        img:
            "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg"),
    Category(
        category: "Bath",
        img:
            "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg"),
    Category(
        category: "Living",
        img:
            "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg"),
    Category(
        category: "Kitchen",
        img:
            "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg"),
    Category(
        category: "Dining",
        img:
            "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg"),
  ];

  final CarouselSliderController carouselController =
      CarouselSliderController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {


    const IconData bed = IconData(0xe0d7, fontFamily: 'MaterialIcons');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Image.asset(
                'assets/images/Logo_22.png',
                // fit: BoxFit.fitHeight,
                height: 40,
              ),
              // Image.asset('assets/images/Splash_logo_text.png',fit: BoxFit.fitHeight,),
            ],
          ),
        ),
        // centerTitle: true,
        title: Text(
          'decoze',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade600,
            fontSize: 28,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search(),
                  ),
                );
              },
              icon: Icon(Iconsax.search_normal_1)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Favourite(
                      favoriteProducts: favoriteProducts,
                      onRemoveFromFavorites: _onRemoveFromFavorites,
                    ),
                  ),
                );
              },
              icon: Icon(Iconsax.heart)),
        ],
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
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 200,
                  width: double.infinity,
                  child: CarouselSlider(
                      items: imageList
                          .map(
                            (item) => Image.asset(
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
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
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
              SizedBox(height: 8),
              SizedBox(
                height: 140,
                child: ListView.builder(
// change in
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      widget.tabChange(1);
                      myCat=categoryList![index].category.toString();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute (
                      //     builder: (context) =>
                      //     ProductDetails(id: globalProductList[index].id),
                      //
                      //     ));
                    },
                    child: Container(
                      // height: 100,
                      // padding: EdgeInsets.all(16),
                      width: 130,
                      // margin: EdgeInsets.symmetric(horizontal: 10),

                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),color: Colors.brown.shade100
                          // Border radius
                          // border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset('assets/images/sofa1.jpeg'),
                            // Icon(bed),
                            Image.network(
                              "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg",
                              height: 85,
                              width: 60,

                            ),
                            Text(
                              categoryList![index].category.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),

                    ),
                  ),
                  itemCount: categoryList?.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Top Selling',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 253,
                child: ListView.builder(
                  itemCount: globalProductList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final product = globalProductList[index];
                    if (double.tryParse(product.rating) != null && double.parse(product.rating) < 4) {
                      return SizedBox(); // Hide products with a rating below 4
                    }

                    return  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute (
                            builder: (context) =>
                                ProductDetails(id: globalProductList[index].id),
                          ),
                        );
                        setState(() {

                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          // color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          // Border radius
                          border: Border.all(color: Colors.brown, width: 1),
                        ),
                        // color: Colors.blue.shade50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                      height: 140,
                                      width: 130,
                                      child: Image.network(
                                        '${globalProductList[index].img}',
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                // Icon(Icons.favorite_border,color: Colors.white,

                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: IconButton.filledTonal(
                                    onPressed: () async {
                                      bool isFavorite = favoriteProducts.any((item) => item.id == product.id);

                                      if (isFavorite) {
                                        await dbHelper.removeFromFav(product.id);
                                        setState(() {
                                          favoriteProducts.removeWhere((item) => item.id == product.id);
                                          Fluttertoast.showToast(msg: 'Favorite Removed', backgroundColor: Colors.red);
                                        });
                                      } else {
                                        int userId = 1; // Replace with actual user ID logic
                                        await dbHelper.addToFav(product, userId);
                                        setState(() {
                                          favoriteProducts.add(product);
                                          Fluttertoast.showToast(msg: 'Favorite Added', backgroundColor: Colors.green);
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      favoriteProducts.any((item) => item.id == product.id) ? Icons.favorite : Icons.favorite_border,
                                      color: favoriteProducts.any((item) => item.id == product.id) ? Colors.red : Colors.brown,
                                    ),
                                    tooltip: 'Favorite',
                                    iconSize: 24,
                                  ),
                                )
                                // Positioned(
                                //   top: 5,
                                //   right: 5,
                                //   child: IconButton.filledTonal(
                                //     onPressed: () async {
                                //       bool isFavorite = favoriteProducts.any((item) => item.id == product.id);
                                //
                                //       if (isFavorite) {
                                //         await dbHelper.removeFromFav(product.id);
                                //         favoriteProducts.removeWhere((item) => item.id == product.id);
                                //         Fluttertoast.showToast(msg: 'Favorite Removed', backgroundColor: Colors.red);
                                //       } else {
                                //         int userId = 1;
                                //         await dbHelper.addToFav(product,userId);
                                //         favoriteProducts.add(product);
                                //         Fluttertoast.showToast(msg: 'Favorite Added', backgroundColor: Colors.green);
                                //       }
                                //
                                //       setState(() {});
                                //     },
                                //     icon: Icon(
                                //       favoriteProducts.any((item) => item.id == product.id) ? Icons.favorite : Icons.favorite_border,
                                //       color: favoriteProducts.any((item) => item.id == product.id) ? Colors.red : Colors.brown,
                                //     ),
                                //     tooltip: 'Favorite',
                                //     iconSize: 24,
                                //   )
                                // )
                              ],
                            ),
                            Text(
                              '${globalProductList[index].category}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              '${globalProductList[index].title}\n',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            Text(
                              '\$${globalProductList[index].price}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Row(
                              spacing: 5,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '${globalProductList[index].rating}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );

                  }
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Text(
                        'Collections',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/sofa1.jpeg',
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 250,
                          ),
                          Positioned(
                            // top: 5,
                            bottom: 10,
                            right: 0,
                            left: 20,
                            child: Text(
                              'Discover New Decorify collection',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/sofa1.jpeg',
                        width: MediaQuery.sizeOf(context).width / 2 - 24,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        // top: 5,
                        bottom: 10,
                        right: 0,
                        left: 20,
                        child: Text(
                          'Furniture Shop',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    // spacing: 16,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/sofa1.jpeg',
                            width: MediaQuery.sizeOf(context).width / 2 - 24,
                            height: 300 / 2 - 8,
                            fit: BoxFit.fitHeight,
                          ),
                          Positioned(
                            // top: 5,
                            bottom: 10,
                            right: 0,
                            left: 20,
                            child: Text(
                              'Explore Decore',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/sofa1.jpeg',
                            width: MediaQuery.sizeOf(context).width / 2 - 24,
                            height: 300 / 2 - 8,
                            fit: BoxFit.fitHeight,
                          ),
                          Positioned(
                            // top: 5,
                            bottom: 10,
                            right: 0,
                            left: 20,
                            child: Text(
                              'Servewares Shop',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Outdoor Collection',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 253,
                child: ListView.builder(
                    itemCount: globalProductList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final product = globalProductList[index];
                      if (double.tryParse(product.rating) != null && double.parse(product.rating) < 4) {
                        // return SizedBox(); // Hide products with a rating below 4
                      }

                      return  GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute (
                              builder: (context) =>
                                  ProductDetails(id: globalProductList[index].id),
                            ),
                          );
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            // color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                            // Border radius
                            border: Border.all(color: Colors.brown, width: 1),
                          ),
                          // color: Colors.blue.shade50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Container(
                                        height: 140,
                                        width: 130,
                                        child: Image.network(
                                          '${globalProductList[index].img}',
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  // Icon(Icons.favorite_border,color: Colors.white,

                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: IconButton.filledTonal(
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
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '${globalProductList[index].category}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text(
                                '${globalProductList[index].title}\n',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                '\$${globalProductList[index].price}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Row(
                                spacing: 5,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    '${globalProductList[index].rating}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );

                    }
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),

      // Center(
      //   child: Container(
      //     child: Text('Comming Soon.....😁',style: TextStyle(fontSize: 20),),
      //   ),
      // ),
    );
  }
}
