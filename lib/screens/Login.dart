import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/dataBase/DataBaseHelperClass.dart';
import 'package:task1/models/UserModel.dart';
import 'package:task1/screens/Home.dart';
import 'package:task1/ui_widgets/custom_textfield.dart';

import 'Bottom_navigationBar.dart';
import 'Sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  final DataBaseHelper dbHelper = DataBaseHelper();

  void login()async{
    String uemail=Email.text.trim();
    String upassword=Password.text.trim();

    if(uemail.isEmpty){
      Fluttertoast.showToast(msg: 'Please Enter Email');
      return;
    }
    else if(upassword.isEmpty){
      Fluttertoast.showToast(msg: 'Please Enter Password');
      return;
    }
    try{
      UserModel? user = await dbHelper!.getUserByEmailAndPassword(uemail);
      if(user != null){
        SharedPreferences sp = await SharedPreferences.getInstance();

        await sp.setString('useremail',user.email);
        Fluttertoast.showToast(msg: 'Login Successful!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationbar()),
        );
      }else {
        Fluttertoast.showToast(msg: 'Invalid Email or Password. Try again!');
      }

        }catch  (error) {
      Fluttertoast.showToast(msg: 'Error: ${error.toString()}');
    }

    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      //   centerTitle: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text("Login",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 45,color:Colors.brown.shade500),),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 35,
              children: [
                CustomTextfield(hintText: 'Email', controller: Email,icon:Icons.email),
                CustomTextfield(hintText: 'Password', controller: Password,icon: Iconsax.lock,),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      onPressed: login,
                        // Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationbar()));

                      style: ElevatedButton.styleFrom(

                        backgroundColor: Colors.brown.shade200,
                        minimumSize: Size(230, 50),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
