import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/screens/Add_To_Cart.dart';

import '../main.dart';
import '../models/ProductModel.dart';
import 'Bottom_navigationBar.dart';
import 'Payment.dart';

class CheckOut extends StatefulWidget {

  CheckOut({super.key, });

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  String _userName = "Guest";

  num delivary_charge=40;
  num subtotal = 0;
  num total = 0;
  num tax_charge=50;
  bool IconDisable = true;

  void initState() {
    super.initState();
    _loadUserName();
    getIntosp();
  }

  void _loadUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _userName = sp.getString('firstname') ?? "Guest";  // Fetch firstname instead of userEmail
    });
    setState(() {

    });
  }

  Future<void> getIntosp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? cartItemsJson = sp.getStringList('cartItems');

    print('[DEBUG] Retrieved cartItems JSON: $cartItemsJson');
    if (cartItemsJson != null) {

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
  void calculateTotal() {
    subtotal = 0;
    cartItems.forEach((element) {
      subtotal += num.parse(element.price.toString()) * element.qty;
    });
    total = subtotal + delivary_charge + tax_charge;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Check out'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            cartItems.isEmpty
                ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Text('No items in cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ):
            ListView.builder(
              itemCount: cartItems.length,
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
                        child: Image.asset(
                          cartItems[index].img.first,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              spacing: 5,
                              children: [
                                GestureDetector(
                                  onTap: IconDisable?null:() {
                                    IconDisable;
                                    setState(() {
                                      if (cartItems[index].qty > 1) {
                                        cartItems[index].qty;
                                        subtotal -= num.parse(cartItems[index].price.toString());
                                        total = subtotal + delivary_charge + tax_charge;
                                      }
                                    });
                                  },
                                  child: Icon(Iconsax.minus_cirlce , color: IconDisable ? Colors.grey : Colors.blue),
                                ),
                                Text(cartItems[index].qty.toString()),
                                GestureDetector(
                                  onTap: IconDisable?null:() {
                                    IconDisable;
                                    setState(() {
                                      cartItems[index].qty;
                                      subtotal += num.parse(cartItems[index].price.toString());
                                      total = subtotal + delivary_charge + tax_charge;

                                    });
                                  },
                                  child: Icon(Iconsax.add_circle,color: IconDisable ? Colors.grey : Colors.blue),
                                )
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
              child:  ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  PaymentScreen(title: ''),
                  ),
                );
                // Razorpay razorpay = Razorpay();
                // var options = {
                //   'key': 'rzp_test_CLw7tH3O3P5eQM',
                //   'amount': '${total*100}',
                //   'name': '${_userName}',
                //   'description': 'Home Decore Items',
                //   'retry': {'enabled': true, 'max_count': 1},
                //   'send_sms_hash': true,
                //   'method': {
                //     'card': true,
                //     'net banking': true,
                //     'wallet': true,
                //     'upi': true,
                //     'paylater': false, // Explicitly disable Pay Later
                //   },
                //   // 'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                //   'external': {
                //     'wallets': ['paytm']
                //   },
                //
                // };
                // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                // razorpay.open(options);
              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade100,
                    minimumSize: Size(300, 50),
                  ),
                  child:  Text("Payment",style: TextStyle(
                      color: Colors.brown.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),)),
            ),
          ],
        ),
      ),

    );
  }
//
//   ******************** razorpay -----------------------
//   void handlePaymentErrorResponse(PaymentFailureResponse response){
//
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents closing by tapping outside
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Rounded corners
//           title: Column(
//             children: [
//               Icon(Icons.close, color: Colors.red, size: 60), // Success Icon
//               const SizedBox(height: 10),
//               const Text("Payment Failed", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             ],
//           ),
//           content: Text("Payment Failed\n",
//               textAlign: TextAlign.center),
//           actionsAlignment: MainAxisAlignment.center, // Centering button
//           actions: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green, // Green for success
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//                 //-------------- back button not show not uncomment -----------------
//                 // // Navigator.of(context).pushReplacement(
//                 // //   MaterialPageRoute(builder: (context) => AddToCart()), // Navigate to Home Screen
//                 // );
//               },
//             ),
//           ],
//         );
//       },
//     );
//
//     // showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
//   }
//
//   void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
//     print("Payment Successful. Payment ID: ${response.paymentId}");
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevents closing by tapping outside
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Rounded corners
//           title: Column(
//             children: [
//               Icon(Icons.check_circle, color: Colors.green, size: 60), // Success Icon
//               const SizedBox(height: 10),
//               const Text("Payment Successful", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//
//             ],
//           ),
//           content: Text("Your payment was successfully processed.\nPayment ID: ${response.paymentId}",
//               textAlign: TextAlign.center),
//           actionsAlignment: MainAxisAlignment.center, // Centering button
//           actions: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green, // Green for success
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => BottomNavigationbar()), // Navigate to Home Screen
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   void handleExternalWalletSelected(ExternalWalletResponse response){
//     showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
//   }
//
//   void showAlertDialog(BuildContext context, String title, String message){
//     // set up the buttons
//     Widget continueButton = ElevatedButton(
//       child: const Text("Continue"),
//       onPressed:  () {},
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(message),
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
}

