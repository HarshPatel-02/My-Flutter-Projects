import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/ProductModel.dart';
import 'package:task1/models/ProductModel.dart';
import 'package:task1/screens/Check_out.dart';
import 'package:task1/screens/Favourite.dart';

import '../dataBase/DataBaseHelperClass.dart';
import '../main.dart';

class AddToCart extends StatefulWidget {

  AddToCart({
    super.key,
  });

  @override
  State<AddToCart> createState() => _AddToCartState();
}


class _AddToCartState extends State<AddToCart> {
  final DataBaseHelper dbHelper = DataBaseHelper.instance;
  bool isVisible = true;
  // int number = 1;
  // var qty;

  num delivary_charge=40;
  num total=0;
  num subtotal=0;
  num tax_charge=50;


  @override
  void initState() {

    super.initState();
    print("CART_SCREEN_DETECT");
    _loadCartItems();

  }
  // void removeItem(int index) {
  //
  //   cartItems.removeAt(index);
  //   _calculateTotal();
  //   _calculateTotal();
  //   // isVisible = !isVisible;
  //   // SetIntosp(cartItems);
  //   setState(() {
  //   });
  //
  // }

  Future<void> _loadCartItems() async {
    try {
      int userId = 1;
      cartItems = await dbHelper.getCartItems(userId);

      print('----cartScreen-${cartItems.length}');

      _calculateTotal();
      setState(() {});
    } catch (e) {
      print("Error loading cart items: $e");
    }
  }

  Future<void> _removeItem(int index) async {
    try {
      await dbHelper.removeFromCart(cartItems[index].id);
      await _loadCartItems(); // Refresh the list
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  Future<void> _updateQuantity(int index, int newQty) async {
    if (newQty < 1) {
      await _removeItem(index);
      return;
    }

    try {
      cartItems[index].qty = newQty;
      await dbHelper.updateCartItem(cartItems[index]);
      _calculateTotal();
      setState(() {});
    } catch (e) {
      print("Error updating quantity: $e");
    }
  }

  void _calculateTotal() {
    subtotal = cartItems.fold(0, (sum, item) => sum + (num.parse(item.price) * item.qty));
    total = subtotal + delivary_charge + tax_charge;
  }



  // void calculateTotal() {
  //   subtotal = 0;
  //   cartItems.forEach((element) {
  //     subtotal += num.parse(element.price.toString()) * element.qty;
  //   });
  //   total = subtotal + delivary_charge + tax_charge;
  //   setState(() {

  //   });
  // }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pop(context); // This takes you back to the previous screen
        //     },
        // ),
        centerTitle: true,
        title: Text('Cart'),
      ),
      body: cartItems.isNotEmpty ?Visibility(
        visible: isVisible,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(itemCount: cartItems.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  height: 170,
                  width: double.infinity,
                  // color: Colors.red,
                  padding: EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey,
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.network(
                            cartItems[index].img,
                            width: 100,
                            fit: BoxFit.fill,
                            height: 120,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Text(
                                cartItems[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreen,
                                ),
                              ),
                              Text(
                                '\$${cartItems[index].price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   width: 70,
                        // ),
                        Column(

                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 32,
                              children: [
                                InkWell(
                                  onTap:(){
                                    _removeItem(index);
                                  },
                                  child: IconButton(onPressed: ()  =>  _removeItem(index),
                                    icon: Icon(Iconsax.trush_square),color: Colors.red,iconSize: 28, ),
                                ),

                                Row(mainAxisAlignment: MainAxisAlignment.end,
                                  spacing: 2,
                                  children: [

                                    IconButton(
                                      onPressed: () => _updateQuantity(index, cartItems[index].qty - 1),
                                      icon: const Icon(Iconsax.minus_cirlce),
                                    ),
                                    Text(cartItems[index].qty.toString()),
                                    IconButton(
                                      onPressed: () => _updateQuantity(index, cartItems[index].qty + 1),
                                      icon: const Icon(Iconsax.add_circle),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: Colors.grey),
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('\$${subtotal}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax and Fees',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('\$${tax_charge}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('\$${delivary_charge}'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              '\$${(subtotal + delivary_charge + tax_charge) }',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 150),
                    child: ElevatedButton(
                        onPressed: cartItems.isNotEmpty?() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new CheckOut(),
                            ),
                          );
                        }:null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown.shade100,
                          minimumSize: Size(250, 50),
                        ),
                        child: Text(
                          'Check Out',
                          style: TextStyle(color: Colors.brown.shade700,fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ):Center(child: Text('Your Cart is Empty',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),

    );
  }
}




