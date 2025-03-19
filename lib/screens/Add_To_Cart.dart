import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/ProductModel.dart';
import 'package:task1/models/ProductModel.dart';
import 'package:task1/screens/Check_out.dart';
import 'package:task1/screens/Favourite.dart';

import '../main.dart';

class AddToCart extends StatefulWidget {

  AddToCart({
    super.key,
  });

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {

bool isVisible = true;
  // int number = 1;
  // var qty;

  num delivary_charge=40;
  num total=0;
  num subtotal=0;
  num tax_charge=50;


  @override
  void initState() {
    print(cartItems.length.toString()+'xyz');
    super.initState();
    print("CART_SCREEN_DETECT");
    SetIntosp(cartItems);

    getIntosp();

  }
  void removeItem(int index) {

      cartItems.removeAt(index);
      calculateTotal();
      // isVisible = !isVisible;
      SetIntosp(cartItems);
      setState(() {
      });

  }



  Future<void> getIntosp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? cartItemsJson = sp.getStringList('cartItems');

    print('[DEBUG] Retrieved cartItems JSON: $cartItemsJson');

    if (cartItemsJson != null) {
      cartItems.clear();
      cartItems = cartItemsJson.map((item) {
        Map<String, dynamic> itemMap = jsonDecode(item);
        return ProductItem.fromMap(itemMap);
      }).toList();
      print('Retrieved cartItems: ${cartItems.length}');
      setState(() {});
    } else {
      print('No cartItems found in SharedPreferences');
    }
    calculateTotal();
  }
  Future<void> SetIntosp(List<ProductItem>cartItems) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> cartItemsJson = cartItems.map((item) => jsonEncode(item.toMap())).toList();
    sp.setStringList('cartItems', cartItemsJson);
    print('Saved cartItems: ${cartItems.length}');
  }

  void calculateTotal() {
    subtotal = 0;
    cartItems.forEach((element) {
      subtotal += num.parse(element.price.toString()) * element.qty;
    });
    total = subtotal + delivary_charge + tax_charge;
    setState(() {

    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(

                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                spacing: 35,
                                children: [
                                  InkWell(
                                    onTap:(){
                                      removeItem(index);
                                    },
                                    child: IconButton(onPressed: (){
                                      setState(() {
                                        removeItem(index);
                                      });
                                    },icon: Icon(Iconsax.trush_square),color: Colors.red,iconSize: 28,),
                                  ),

                                  Row(mainAxisAlignment: MainAxisAlignment.end,
                                    spacing: 5,
                                    children: [

                                      GestureDetector(
                                        onTap: () {

                                            if (cartItems[index].qty > 1) {
                                              cartItems[index].qty--;
                                              subtotal -= num.parse(cartItems[index].price.toString());
                                              total = subtotal + delivary_charge + tax_charge;

                                            }
                                            else{
                                              removeItem(index);

                                            }
                                            calculateTotal();
                                            SetIntosp(cartItems);
                                            setState(() {});

                                        },
                                        child: Icon(Iconsax.minus_cirlce),

                                      ),
                                      Text(cartItems[index].qty.toString()),
                                      GestureDetector(
                                        onTap: () {

                                            cartItems[index].qty++;
                                            subtotal += num.parse(cartItems[index].price.toString());
                                            total = subtotal + delivary_charge + tax_charge;
setState(() {

});
                                        },
                                        child: Icon(Iconsax.add_circle),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                    padding: const EdgeInsets.symmetric(vertical: 200),
                    child: ElevatedButton(
                        onPressed: cartItems.isNotEmpty?() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new CheckOut(subtotal: subtotal, total: total),
                            ),
                          );
                        }:null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown.shade200,
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




