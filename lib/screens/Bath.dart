// import 'package:flutter/material.dart';
// import '../models/dataProvider.dart';
// import 'BedRoom.dart';
// import 'Category.dart';
// import 'Dinning.dart';
// import 'Kitchen.dart';
// import 'Living.dart';
// import 'Product_details.dart';
//
// class Bath extends StatefulWidget {
//   const Bath({super.key});
//
//   @override
//   State<Bath> createState() => _BathState();
// }
//
// class _BathState extends State<Bath> {
//   String selectedCategory = "Bath";
//   @override
//   Widget build(BuildContext context) {
//     final filteredProducts = globalProductList.where((product) => product.category == selectedCategory).toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(selectedCategory),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.arrow_back_ios),
//               onPressed: () {
//                 Navigator.pop(context,true); // Goes back to the previous screen
//               },
//               tooltip: MaterialLocalizations.of(context).backButtonTooltip,
//             );
//           },
//         ),
//
//       ),
//       body:
//       Column(
//         children: [
//           SingleChildScrollView(padding: EdgeInsets.all(16),
//             scrollDirection: Axis.horizontal,
//             child:
//             Container(
//               child: Row(
//                 spacing: 10,
//                 children: [
//                   categoryButton("All", "All"),
//                   categoryButton("Bedroom", "Bedroom"),
//                   categoryButton("Bath", "Bath"),
//                   categoryButton("Living Room", "Living"),
//                   categoryButton("Kitchen", "Kitchen"),
//                   categoryButton("Dining", "Dining"),
//                   // OutlinedButton(
//                   //     onPressed: () {},
//                   //     style: ElevatedButton.styleFrom(
//                   //       minimumSize: Size(100, 35),
//                   //     ),
//                   //     child: Text('All')),
//                   // OutlinedButton(
//                   //     onPressed: () {
//                   //       Navigator.of(context).push(
//                   //         MaterialPageRoute(builder: (context) => const Bedroom()),
//                   //       );
//                   //     },
//                   //     style: ElevatedButton.styleFrom(
//                   //       minimumSize: Size(120, 35),
//                   //     ),
//                   //     child: Text('Bedroom')),
//                   // OutlinedButton(
//                   //     onPressed: () {
//                   //       Navigator.of(context).push(
//                   //         MaterialPageRoute(builder: (context) => const Bath()),
//                   //       );
//                   //     },
//                   //     style: ElevatedButton.styleFrom(
//                   //       minimumSize: Size(110, 35),
//                   //     ),
//                   //     child: Text('Bath')),
//                   // OutlinedButton(
//                   //     onPressed: () {
//                   //       Navigator.of(context).push(
//                   //         MaterialPageRoute(builder: (context) => const Living()),
//                   //       );
//                   //     },
//                   //     style: ElevatedButton.styleFrom(
//                   //       minimumSize: Size(100, 35),
//                   //     ),
//                   //     child: Text('Living Room')),
//                   // OutlinedButton(
//                   //     onPressed: () {
//                   //       Navigator.of(context).push(
//                   //         MaterialPageRoute(builder: (context) => const Kitchen()),
//                   //       );
//                   //     },
//                   //     style: ElevatedButton.styleFrom(
//                   //       minimumSize: Size(100, 35),
//                   //     ),
//                   //     child: Text('kitchen')),
//                   // OutlinedButton(
//                   //     onPressed: () {
//                   //       Navigator.of(context).push(
//                   //         MaterialPageRoute(builder: (context) => const Dinning()),
//                   //       );
//                   //     },
//                   //     style: ElevatedButton.styleFrom(
//                   //       minimumSize: Size(100, 35),
//                   //     ),
//                   //     child: Text('Dining')),
//                 ],
//               ),
//
//             ),
//
//
//           ),
//           Divider(thickness: 2),
//           Expanded(
//             child: GridView.builder(
//               scrollDirection: Axis.vertical,
//               gridDelegate:
//               SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,childAspectRatio: 0.70),
//               itemCount: filteredProducts.length,
//               itemBuilder: (context, index) {
//                 var product = filteredProducts[index];
//                 return InkWell(onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => new ProductDetails(id:filteredProducts[index].id
//                   ),));
//
//                   },
//                     child: Container(
//                       padding: EdgeInsets.all(8),
//                       margin: EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         // color: Colors.blue.shade50,
//                         borderRadius: BorderRadius.circular(8), // Border radius
//                         border: Border.all(color: Colors.grey, width: 1),),
//                       // color: Colors.blue.shade50,
//                       child:Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Stack(
//                             children:<Widget> [
//
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(6),
//                                 child: Container(
//
//                                     color: Colors.red,
//                                     child: Image.network(product.img,fit: BoxFit.fill,height: 165,width: 300,)),
//                               ),
//                               // Icon(Icons.favorite_border,color: Colors.white,
//
//                               Positioned(
//                                 top: 5,
//                                 right: 5,
//                                 child: IconButton.filledTonal(onPressed: () {
//
//                                 }, icon: const Icon(Icons.favorite_border),tooltip: 'favorite',iconSize: 18,),
//                               )
//                             ],
//                           ),
//                           Text(product.category,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
//                           Text(product.title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
//                           Text('\$${product.price}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
//                           Row(
//
//                             spacing: 5,
//                             children: [
//                               Icon(Icons.star,size: 18,color:Colors.amber,),
//                               Text('${product.rating}',style: TextStyle(fontSize: 10,fontWeight:FontWeight.bold),)
//                             ],
//                           )
//
//                         ],
//                       ),
//
//                     ),
//
//                 );
//               },
//             ),
//           ),
//
//         ],
//       ),
//     );
//
//
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
