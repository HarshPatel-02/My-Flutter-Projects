import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/screens/Favourite.dart';
import 'package:task1/screens/Order_Screen.dart';
import 'package:task1/screens/userprofile.dart';

import '../dataBase/DataBaseHelperClass.dart';
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
  String? _profileImage;

  final DataBaseHelper dbHelper = DataBaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Load username when screen opens
  }
  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id'); // Get the logged-in user's ID

    if (userId != null) {
      try {
        final profile = await dbHelper.getUserProfile(userId);
        setState(() {
          _userName = profile != null && profile[DataBaseHelper.P_FIRSTNAME] != null
              ? profile[DataBaseHelper.P_FIRSTNAME]
              : "Guest"; // Use firstname from profile or "Guest"
          _profileImage = profile != null ? profile[DataBaseHelper.P_IMAGE] : null;
        });
      } catch (e) {
        print('Error loading user profile: $e');
        setState(() {
          _userName = "Guest"; // Fallback in case of error
        });
      }
    } else {
      setState(() {
        _userName = "Guest"; // No user ID, so default to "Guest"
      });
    }
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
                Stack(
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: _profileImage != null
                            ? Image.memory(base64Decode(_profileImage!), fit: BoxFit.cover)
                            : const Image(
                          image: NetworkImage('https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.brown),
                        child:  InkWell(onTap: () async {
                          // Await added
                          bool? isUpdated = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const userprofile()),
                          );
                          if (isUpdated == true) {
                            _loadUserName(); // Refresh after update
                          }
                        },
                            child: Icon(Icons.edit , size: 20,color: Colors.brown.shade200,)),

                      ),
                    )
                  ],
                ),
                // Icon(Icons.account_circle,size: 120,color: Colors.brown.shade300),
                Text('Welcome, $_userName',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.brown.shade500),),
             // edit link
                // TextButton(
                //     onPressed: () async{
                //       bool? isUpdated = await
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => userprofile()));
                //       if (isUpdated == true) {
                //         _loadUserName(); // ✅ Refresh the name if data was updated
                //       }
                //     },
                //     child: Text(
                //       'Edit Profile',
                //       style: TextStyle(
                //           color: Colors.blue,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 16),
                //     ))

              ],
            ),
          ),
          Positioned(bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height:MediaQuery.of(context).size.height*0.62,

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
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.brown, width: 2),
                                ),
                                child: IconButton(onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => OrderScreen()),
                                  );
                                }, icon:Icon(Icons.card_travel),iconSize: 32,)
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
                      InkWell(
                              onTap: () async {
                                SharedPreferences sp = await SharedPreferences.getInstance();
                                // await sp.clear();
                                await dbHelper.logout();
                                // await dbHelper.clearFav();
                                // await dbHelper.clearCart();
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()),
                                        (route)=>false );
                              },
                          child: Icon(Icons.exit_to_app_sharp,size: 32,color: Colors.red.shade600,)),
                      TextButton(onPressed: () async {
                        SharedPreferences sp = await SharedPreferences.getInstance();
                        // await sp.clear();
                        await dbHelper.logout();
                        // await dbHelper.clearFav();
                        // await dbHelper.clearCart();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()),
                            (route)=>false );
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
