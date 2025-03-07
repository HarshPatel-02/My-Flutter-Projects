import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Theme/theme.dart';
import 'package:task1/screens/Add_To_Cart.dart';
import 'package:task1/screens/Bath_details.dart';
import 'package:task1/screens/BedRoom.dart';
import 'package:task1/screens/Product_details.dart';
import 'package:task1/screens/Category.dart';
import 'package:task1/screens/Dining_details.dart';
import 'package:task1/screens/Dinning.dart';
import 'package:task1/screens/Home.dart';
import 'package:task1/screens/Kitchen_details.dart';
import 'package:task1/screens/Login.dart';
import 'package:task1/screens/Sign_up-Extra.dart';
import 'package:task1/screens/Sign_up.dart';
import 'package:task1/screens/Splash.dart';
import 'package:task1/screens/api.dart';
import 'package:task1/screens/profile.dart';
import 'package:task1/screens/Bottom_navigationBar.dart';
import 'package:task1/screens/userapp.dart';

import 'models/ProductModel.dart';
import 'screens/Bottom_navigationBar.dart';

List<ProductItem> cartItems=[];

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,   //debugge nu lable off krva

      home: const MyHomePage(title: 'Task 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     brightness:Brightness.light,
      // ),
      // home: Home(),
      // home:profile(),
      //   home: Login(),
    // home: SignUp(),
    // home: BottomNavigationbar(),
    //   home: Bedroom(),
    //   home: Dinning(),

      // home: BedroomDetails(),
      // home: BathDetails(),
      // home: DiningDetails(),
      // home: KitchenDetails(),

    // home: Categorys(),
      home: SplashScreen(),
      // home: Userapp(),
      // home: AddToCart(id: '',),

      // theme: lightMode,
      // darkTheme: darkMode,
    );
  }
}
