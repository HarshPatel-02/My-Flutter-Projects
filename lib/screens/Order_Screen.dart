import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/dataBase/DataBaseHelperClass.dart';
import 'package:task1/main.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  final DataBaseHelper dbHelper = DataBaseHelper.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadOrderItems();
    print("----Order");
  }
  Future<void> _loadOrderItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');
      if(userId !=null) {
        orderItems = await dbHelper.getOrderItems(userId);
        print('----OrderScreen${orderItems.length}');
        setState(() {});
      }else{
        print('no user id found');
      }
    } catch (e) {
      print("Error loading cart items: $e");
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
          title: Text('Order Details'),
      ),

      body: orderItems.isEmpty ? Center(
        child: Text('No Order Details'),
        
      ): SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: orderItems.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                height: 180,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,width: 1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                    child: Row(
                      spacing: 10,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.network(
                            orderItems[index].img,
                            width: 100,
                            fit: BoxFit.fill,
                            height: 120,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing:2,
                            children: [

                              Text(
                                'Order Date & Time: ${orderItems[index].orderDate}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown.shade500,
                                ),
                              ),
                              Text(
                                'Product Name : ${orderItems[index].title}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreen,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Price : \$${orderItems[index].price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Quantity : ${orderItems[index].qty}',
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

                      ],
                    ),
                  ),
                ),
              ),
          ],
        )

        ),
      );
  }
}
