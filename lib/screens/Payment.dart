import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/screens/Bottom_navigationBar.dart';
import '../dataBase/DataBaseHelperClass.dart';
import '../main.dart';
import 'package:http/http.dart' as http;


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.title});

  final String title;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _userName = "Guest";
  num delivery_charge = 40;
  num subtotal = 0;
  num total = 0;
  num tax_charge = 50;
  // List<ProductItem> cartItems = [];
  late Razorpay _razorpay;
  num exchangeRate = 85;

  final DataBaseHelper dbHelper = DataBaseHelper.instance;


  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadCartItems();

    // getIntosp();

    // Initialize Razorpay once
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  Future<num> getLiveExchangeRate() async {
    final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'); // Replace with any reliable API    //85.63
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['rates']['INR']; // Get the INR rate from USD
    } else {
      throw Exception("Failed to fetch exchange rate");
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _loadUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _userName = sp.getString('firstname') ?? "Guest";
    });
  }
  Future<void> _loadCartItems() async {
    try {
      int userId = 1;
      cartItems = await dbHelper.getCartItems(userId);
      _calculateTotal();
      setState(() {});
    } catch (e) {
      print("Error loading cart items: $e");
    }
  }

  // Future<void> getIntosp() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   List<String>? cartItemsJson = sp.getStringList('cartItems');
  //
  //   if (cartItemsJson != null) {
  //     cartItems = cartItemsJson.map((item) {
  //       return ProductItem.fromMap(jsonDecode(item));
  //     }).toList();
  //     setState(() {});
  //   }
  //   _calculateTotal();
  // }

  // void calculateTotal() {
  //   subtotal = 0;
  //   for (var element in cartItems) {
  //     subtotal += num.parse(element.price.toString()) * element.qty;
  //   }
  //   total = subtotal + deliveryCharge + taxCharge;
  // }
  void _calculateTotal() {
    subtotal = cartItems.fold(0, (sum, item) => sum + (num.parse(item.price) * item.qty));
    total = subtotal + delivery_charge + tax_charge;
  }



  void startPayment() async{

    num exchangeRate = await getLiveExchangeRate(); // Fetch live rate
    num amountInINR = total * 100 * exchangeRate;

    var options = {
      'key': 'rzp_test_CLw7tH3O3P5eQM',
      'amount': '${amountInINR}',
      'currency': 'INR',
      'name': '${_userName}',
      'description': 'Home Decore Items',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'method': {
        'card': true,
        'net banking': true,
        'wallet': true,
        'upi': true,
        'paylater': false, // Explicitly disable Pay Later
      },
      // 'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      },

    };
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Choose Payment Method',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(
            //   'Choose Payment Method',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 20),

            /// **Razorpay Button**
            ElevatedButton(
              onPressed: startPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Pay with Razorpay",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),

            const SizedBox(height: 20),

            /// **Cash on Delivery Button**
            ElevatedButton(
              onPressed: () {
                _showCODDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Cash on Delivery",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _showCODDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Order"),
          content: const Text(
              "Are you sure you want to place an order with Cash on Delivery?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order placed successfully!")),
                );
              },
              child: const Text(
                  "Confirm", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }


  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          // Rounded corners
          title: Column(
            children: [
              Icon(Icons.close, color: Colors.red, size: 60), // Success Icon
              const SizedBox(height: 10),
              const Text("Payment Failed",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text("Payment Failed\n",
              textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          // Centering button
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Green for success
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Continue",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                //-------------- back button not show not uncomment -----------------
                // // Navigator.of(context).pushReplacement(
                // //   MaterialPageRoute(builder: (context) => AddToCart()), // Navigate to Home Screen
                // );
              },
            ),
          ],
        );
      },
    );

    // showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    print("Payment Successful. Payment ID: ${response.paymentId}");
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          // Rounded corners
          title: Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              // Success Icon
              const SizedBox(height: 10),
              const Text("Payment Successful",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            ],
          ),
          content: Text(
              "Your payment was successfully processed.\nPayment ID: ${response
                  .paymentId}",
              textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          // Centering button
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Green for success
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Continue",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) =>
                      BottomNavigationbar()), // Navigate to Home Screen
                );
              },
            ),
          ],
        );
      },
    );
  }


  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
