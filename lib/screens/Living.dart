import 'package:flutter/material.dart';
import 'package:task1/screens/Category.dart';
import '../models/dataProvider.dart';

import 'Bath.dart';
import 'BedRoom.dart';
import 'Dinning.dart';
import 'Kitchen.dart';

class Living extends StatefulWidget {
  const Living({super.key});

  @override
  State<Living> createState() => _LivingState();
}

class _LivingState extends State<Living> {

  String selectedCategory = "Living";

  @override
  Widget build(BuildContext context) {

    final filteredProducts = globalProductList.where((product) => product.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(selectedCategory),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context,true); // Goes back to the previous screen
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),

      ),
      body:
      Column(
        children: [
          SingleChildScrollView(padding: EdgeInsets.all(16),
            scrollDirection: Axis.horizontal,
            child:
            Container(
              child: Row(
                spacing: 10,
                children: [
                  categoryButton("All", "All"),
                  categoryButton("Bedroom", "Bedroom"),
                  categoryButton("Bath", "Bath"),
                  categoryButton("Living Room", "Living"),
                  categoryButton("Kitchen", "Kitchen"),
                  categoryButton("Dining", "Dining"),
                ],
              ),

            ),


          ),
          Divider(thickness: 2),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,childAspectRatio: 0.78),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                var product = filteredProducts[index];
                return Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    // color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8), // Border radius
                    border: Border.all(color: Colors.grey, width: 1),),
                  // color: Colors.blue.shade50,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children:<Widget> [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(

                                color: Colors.red,
                                child: Image.asset('assets/images/sofa1.jpeg',fit: BoxFit.fitHeight,height: 120,)),
                          ),
                          // Icon(Icons.favorite_border,color: Colors.white,

                          Positioned(
                            top: 5,
                            right: 5,
                            child: IconButton.filledTonal(onPressed: () {

                            }, icon: const Icon(Icons.favorite_border),tooltip: 'favorite',iconSize: 18,),
                          )
                        ],
                      ),
                      Text(product.category,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                      Text(product.title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                      Text('\$${product.price}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                      Row(

                        spacing: 5,
                        children: [
                          Icon(Icons.star,size: 18,color:Colors.amber,),
                          Text('${product.rating}',style: TextStyle(fontSize: 10,fontWeight:FontWeight.bold),)
                        ],
                      )

                    ],
                  ),

                );
              },
            ),
          ),

        ],
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
          backgroundColor: selectedCategory == category ? Colors.lightGreen.shade400
              : Colors.white,
          foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
        ),
        child: Text(label),
      ),
    );
  }
}

