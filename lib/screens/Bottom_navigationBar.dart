import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path/path.dart';
import 'package:task1/screens/Add_To_Cart.dart';
import 'package:task1/screens/Home.dart';

import 'package:task1/screens/Cart.dart';
import 'package:task1/screens/Splash.dart';

import 'package:task1/screens/userprofile.dart';

import 'package:task1/screens/Category.dart';

import 'Profile.dart';
import 'Sign_up-Extra.dart';

class BottomNavigationbar extends StatefulWidget {
  // final String titleScreen;

  // BottomNavigationbar({super.key, required this.titleScreen});
  BottomNavigationbar({super.key, });

  @override
  State<BottomNavigationbar> createState() => _BottomNavigationbarState();
}


class _BottomNavigationbarState extends State<BottomNavigationbar> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController=TabController(length: 4, vsync: this);
  }

  TabController? tabController;

  int myIndex = 0;
  List<Widget> widgetList = [

    Home(),
    Categorys(category: 'All',),
    AddToCart(),
    Profile(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.titleScreen,
      //     style: TextStyle(fontFamily: "Oswald-Bold", fontSize: 18),
      //   ),
      //   centerTitle: true,
      // ),

      body:TabBarView(
        children: widgetList,
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        // index: myIndex,
      ),

      bottomNavigationBar: BottomNavigationBar(

        // backgroundColor: Colors.brown.shade200,

          selectedItemColor: Colors.brown.shade500,
          unselectedItemColor: Colors.brown.shade300,
          onTap: (index) {
            setState(() {
              myIndex = index;

            });
            tabController!.animateTo(index);
          },
          currentIndex: myIndex,

          type: BottomNavigationBarType.fixed,items: [
        BottomNavigationBarItem(

          icon: Icon(Iconsax.home,),
          label: 'Home',
        ),

        BottomNavigationBarItem(
            icon: Icon(Iconsax.category,),
            label: 'Category'
        ),
        BottomNavigationBarItem(
            icon: Icon(Iconsax.shopping_bag,),
            label: 'Cart'
        ),
        BottomNavigationBarItem(
            icon: Icon(Iconsax.user_square,),
            label: 'Profile'
        )
      ]),

      // bottomNavigationBar: NavigationBar(
      //     height: 65,
      //     elevation: 0,
      //     selectedIndex: 0,
      //     onDestinationSelected: (index)=> ,
      //
      //     destinations: const [
      //   NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
      //   NavigationDestination(icon: Icon(Iconsax.category), label: 'Category'),
      //   NavigationDestination(icon: Icon(Iconsax.shopping_bag), label: 'Cart'),
      //   NavigationDestination(
      //       icon: Icon(Iconsax.user_square), label: 'Profile'),
      // ]),
    );
  }
}
