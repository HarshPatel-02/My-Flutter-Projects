import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Theme/theme.dart';
import 'package:task1/screens/Add_To_Cart.dart';
import 'package:task1/screens/Bath_details.dart';
import 'package:task1/screens/BedRoom.dart';
import 'package:task1/screens/Payment.dart';
import 'package:task1/screens/Product_details.dart';
import 'package:task1/screens/Category.dart';
import 'package:task1/screens/Dining_details.dart';
import 'package:task1/screens/Dinning.dart';
import 'package:task1/screens/Home.dart';
import 'package:task1/screens/Kitchen_details.dart';
import 'package:task1/screens/Login.dart';
import 'package:task1/screens/Profile.dart';
import 'package:task1/screens/Search.dart';
import 'package:task1/screens/Sign_up-Extra.dart';
import 'package:task1/screens/Sign_up.dart';
import 'package:task1/screens/Splash.dart';
import 'package:task1/screens/WelcomeScreen.dart';
import 'package:task1/screens/api.dart';
import 'package:task1/screens/userprofile.dart';
// import 'package:task1/screens/userprofile.dart';
import 'package:task1/screens/Bottom_navigationBar.dart';
import 'package:task1/screens/userapp.dart';

import 'dataBase/DataBaseHelperClass.dart';
import 'dataBase/UserScreen.dart';
import 'models/ProductModel.dart';
import 'screens/Bottom_navigationBar.dart';

List<ProductItem> cartItems=[];
List<ProductItem> favoriteProducts = [];
List<ProductItem> orderItems=[];


var myCat=null;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenWelcome = prefs.getBool('hasSeenWelcome') ?? false;

  DataBaseHelper dbHelper = DataBaseHelper.instance;
  // await dbHelper.printAllTables();
  // await dbHelper.deleteDatabaseFile();
  await dbHelper.printTableData();
  // await dbHelper.printTableColumns('CART');
  // await dbHelper.printTableColumns('FAVOURITE');

  runApp(MyApp(hasSeenWelcome: hasSeenWelcome));
}

class MyApp extends StatelessWidget {
  final bool hasSeenWelcome;

  const MyApp({super.key, required this.hasSeenWelcome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: hasSeenWelcome ? SplashScreen() : Welcomescreen(),
    );
  }
}
/*

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  DataBaseHelper dbHelper = DataBaseHelper.instance;
  // await dbHelper.printAllTables();
 // await dbHelper.deleteDatabaseFile();
  await dbHelper.printTableColumns('CART');
  await dbHelper.printTableColumns('FAVOURITE');
  await SharedPreferences.getInstance();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? hasSeenWelcome = prefs.getBool('hasSeenWelcome') ?? false;
  runApp( MyApp( hasSeenWelcome:hasSeenWelcome ,));
}

class MyApp extends StatelessWidget {
  final bool hasSeenWelcome;

   MyApp({super.key,required this.hasSeenWelcome});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,   //debugge nu lable off krva

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });



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
      // home:Profile(),
      // home: Login(),
    // home: SignUp(),
    // home: BottomNavigationbar(),
    //   home: Bedroom(),
    //   home: Dinning(),

      // home: BedroomDetails(),
      // home: BathDetails(),
      // home: DiningDetails(),
      // home: KitchenDetails(),
      // home: Search(),
    // home: Categorys(),
    //   home: SplashScreen(),
      home: hasSeenWelcome ? SplashScreen() : Welcomescreen(),

      //   home: UsersScreen(),
      // home: Userapp(),
      // home: AddToCart(),
      // home: Profile(),
      //    home: Welcomescreen(),

      // home: Payment(),
      // theme: lightMode,
      // darkTheme: darkMode,
    );
  }
}

*/

