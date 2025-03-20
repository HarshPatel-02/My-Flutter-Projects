import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/screens/Favourite.dart';
import 'package:task1/screens/userprofile.dart';

import '../main.dart';
import 'Add_To_Cart.dart';
import 'Login.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String _userName = "Guest";
  @override
  void initState() {
    super.initState();
    _loadUserName(); // Load username when screen opens
  }
  void _loadUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _userName = sp.getString('userEmail') ?? "Guest"; // Default if no name found
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height; // Get screen height


    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor:Colors.brown.shade100,
      ),

      //  method 2
      body: Stack(
        children: [
          Container(
            height:MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.brown.shade100,
            child: Column(
              children: [
                // SizedBox(height: 40,),
                Icon(Icons.account_circle,size: 120,color: Colors.brown.shade300),
                Text('Welcome , $_userName!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.brown.shade500),),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => userprofile()));
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))

              ],
            ),
          ),
          Positioned(bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height:MediaQuery.of(context).size.height*0.60,

              // margin: EdgeInsets.symmetric(vertical:10 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),color: Colors.brown.shade200, // Border radius

              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Row(
                          spacing: 20,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.brown, width: 2),
                                ),
                                child: IconButton(onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Favourite(favoriteProducts: favoriteProducts,onRemoveFromFavorites: (p0) {

                                    },)),
                                  );
                                }, icon:Icon(Iconsax.heart),iconSize: 32,)
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.brown, width: 2),
                                ),
                                child: IconButton(onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AddToCart()),
                                  );
                                }, icon:Icon(Icons.shopping_cart_outlined),iconSize: 32,)
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.exit_to_app_sharp,size: 32,color: Colors.red.shade600,),
                      TextButton(onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()),);
                      }, child: Text('Logout',style: TextStyle(fontSize: 25,color: Colors.red.shade600,fontWeight: FontWeight.w600),)
                      )

                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}
