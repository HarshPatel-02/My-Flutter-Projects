import 'package:flutter/material.dart';
import 'package:task1/screens/Bath.dart';
import 'package:task1/screens/Product_details.dart';
import 'package:task1/screens/Kitchen.dart';
import 'package:task1/screens/Living.dart';
import '../models/dataProvider.dart';

import 'BedRoom.dart';
import 'Dinning.dart';

class Categorys extends StatefulWidget {
  // String category;
  const Categorys({super.key,});

  @override
  State<Categorys> createState() => _CategorysState();
}

class _CategorysState extends State<Categorys> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    // Filtering products based on selectedCategory
    final filteredProducts = selectedCategory == "All"
        ? globalProductList.toList()
        : globalProductList.where((product) => product.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Wrap(
              spacing: 8.0,
              children: [
                categoryButton("All", "All"),
                categoryButton("Bedroom", "Bedroom"),
                categoryButton("Bath", "Bath"),
                categoryButton("Living Room", "Living"),
                categoryButton("Kitchen", "Kitchen"),
                categoryButton("Dining", "Dining"),
              ],
            ),
            Divider(thickness: 2),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 10, childAspectRatio: 0.65),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  var product = filteredProducts[index];
                  return InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new ProductDetails(id:filteredProducts[index].id
                    ),));

                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(

                                child: Image.network(product.img,
                                    fit: BoxFit.fill, height: 165, width: 300),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton.filledTonal(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite_border),
                                tooltip: 'favorite',
                                iconSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(product.category,
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.green)),
                        Text('\$${product.price}',
                            style:
                            TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                        Row(
                          children: [
                            Icon(Icons.star, size: 18, color: Colors.amber),
                            Text('4.6',
                                style:
                                TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  );
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(

                                child: Image.network(product.img,
                                    fit: BoxFit.fill, height: 165, width: 300),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton.filledTonal(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite_border),
                                tooltip: 'favorite',
                                iconSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(product.category,
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.green)),
                        Text('\$${product.price}',
                            style:
                            TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                        Row(
                          children: [
                            Icon(Icons.star, size: 18, color: Colors.amber),
                            Text('4.6',
                                style:
                                TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String label, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedCategory = category;
          });
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 35),
          backgroundColor:
          selectedCategory == category ? Colors.lightGreen.shade400 : Colors.white,
          foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
        ),
        child: Text(label),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:task1/screens/Bath.dart';
// import 'package:task1/screens/Kitchen.dart';
// import 'package:task1/screens/Living.dart';
// import '../models/dataProvider.dart';
//
// import 'BedRoom.dart';
// import 'Dinning.dart';
//
// class Categorys extends StatefulWidget {
//   const Categorys({super.key});
//
//   @override
//   State<Categorys> createState() => _CategorysState();
// }
//
// class _CategorysState extends State<Categorys> {
//   String selectedCategory = "";
//
//   Color buttonColor = Colors.blue; // Initial button color
//
//   void changeColor() {}
//
//   @override
//   Widget build(BuildContext context) {
//     final filteredProducts = globalProductList.toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Category'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Wrap(
//               spacing: 8.0,
//               children: [
//                 categoryButton("All", "All"),
//                 categoryButton("Bedroom", "Bedroom"),
//                 categoryButton("Bath", "Bath"),
//                 categoryButton("Living Room", "Living"),
//                 categoryButton("Kitchen", "Kitchen"),
//                 categoryButton("Dining", "Dining"),
//                 // OutlinedButton(
//                 //     onPressed: () {},
//                 //     style: ElevatedButton.styleFrom(
//                 //       minimumSize: Size(100, 35),
//                 //     ),
//                 //     child: Text('All')),
//                 // OutlinedButton(
//                 //     onPressed: () {
//                 //       Navigator.of(context).push(
//                 //         MaterialPageRoute(builder: (context) => const Bedroom()),
//                 //       );
//                 //     },
//                 //     style: ElevatedButton.styleFrom(
//                 //       minimumSize: Size(120, 35),
//                 //     ),
//                 //     child: Text('Bedroom')),
//                 // OutlinedButton(
//                 //     onPressed: () {
//                 //       Navigator.of(context).push(
//                 //         MaterialPageRoute(builder: (context) => const Bath()),
//                 //       );
//                 //     },
//                 //     style: ElevatedButton.styleFrom(
//                 //       minimumSize: Size(110, 35),
//                 //     ),
//                 //     child: Text('Bath')),
//                 // OutlinedButton(
//                 //     onPressed: () {
//                 //       Navigator.of(context).push(
//                 //         MaterialPageRoute(builder: (context) => const Living()),
//                 //       );
//                 //     },
//                 //     style: ElevatedButton.styleFrom(
//                 //       minimumSize: Size(100, 35),
//                 //     ),
//                 //     child: Text('Living Room')),
//                 // OutlinedButton(
//                 //     onPressed: () {
//                 //       Navigator.of(context).push(
//                 //         MaterialPageRoute(builder: (context) => const Kitchen()),
//                 //       );
//                 //     },
//                 //     style: ElevatedButton.styleFrom(
//                 //       minimumSize: Size(100, 35),
//                 //     ),
//                 //     child: Text('kitchen')),
//                 // OutlinedButton(
//                 //     onPressed: () {
//                 //       Navigator.of(context).push(
//                 //         MaterialPageRoute(builder: (context) => const Dinning()),
//                 //       );
//                 //     },
//                 //     style: ElevatedButton.styleFrom(
//                 //       minimumSize: Size(100, 35),
//                 //     ),
//                 //     child: Text('Dining')),
//               ],
//             ),
//             Divider(
//               thickness: 2,
//             ),
//             Expanded(
//               child: GridView.builder(
//                 scrollDirection: Axis.vertical,
//                 gridDelegate:
//                 SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,childAspectRatio: 0.65),
//                 itemCount: filteredProducts.length,
//                 itemBuilder: (context, index) {
//                   var product = filteredProducts[index];
//                   return Container(
//                     padding: EdgeInsets.all(8),
//                     margin: EdgeInsets.symmetric(horizontal: 5),
//                     decoration: BoxDecoration(
//                       // color: Colors.blue.shade50,
//                       borderRadius: BorderRadius.circular(8), // Border radius
//                       border: Border.all(color: Colors.grey, width: 1),),
//                     // color: Colors.blue.shade50,
//                     child:Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Stack(
//                           children:<Widget> [
//
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(6),
//                               child: Container(
//
//                                   color: Colors.red,
//                                   child: Image.network(product.img,fit: BoxFit.fill,height: 165,width: 300,)),
//
//                             ),
//                             // Icon(Icons.favorite_border,color: Colors.white,
//
//                             Positioned(
//                               top: 5,
//                               right: 5,
//                               child: IconButton.filledTonal(onPressed: () {
//
//                               }, icon: const Icon(Icons.favorite_border),tooltip: 'favorite',iconSize: 18,),
//                             )
//                           ],
//                         ),
//                         Text(product.category,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
//                         Text(product.title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
//                         Text('\$${product.price}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
//                         Row(
//
//                           spacing: 5,
//                           children: [
//                             Icon(Icons.star,size: 18,color:Colors.amber,),
//                             Text('4.6',style: TextStyle(fontSize: 10,fontWeight:FontWeight.bold),)
//                           ],
//                         )
//
//                       ],
//                     ),
//
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//
//     );
//   }
//
//   Widget categoryButton(String label, String category) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       child: OutlinedButton(
//         onPressed: () {
//           setState(() {
//             selectedCategory = category;
//           });
//         },
//         style: ElevatedButton.styleFrom(
//           minimumSize: Size(100, 35),
//           backgroundColor: selectedCategory == category ? Colors.lightGreen.shade400
//               : Colors.white,
//           foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
//         ),
//         child: Text(label),
//       ),
//     );
//   }
// }
//
//
