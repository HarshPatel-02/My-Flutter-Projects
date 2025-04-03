import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/dataBase/DataBaseHelperClass.dart';
import 'package:task1/models/UserModel.dart';
import 'package:task1/ui_widgets/custom_textfield.dart';

import '../dataBase/UserScreen.dart';
import 'Bottom_navigationBar.dart';
import 'Sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey= GlobalKey<FormState>();

  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  final DataBaseHelper dbHelper = DataBaseHelper.instance;

  bool _obscureText = true;


  void login() async {
    String uemail = Email.text.trim();
    String upassword = Password.text.trim();
    final bool isValid = EmailValidator.validate(uemail);
    if (uemail.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Email');
      return;
    }
    if (upassword.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Password');
      return;
    }
    if (uemail == "admin" && upassword == "admin") {
      Fluttertoast.showToast(msg: 'Admin Login Successful!');
      print('Admin logged in');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UsersScreen()),
      );
      return;
    }

    try {
      UserModel? user = await dbHelper.getUserByEmail(uemail);

      if (user == null || user.password.isEmpty) {
        Fluttertoast.showToast(msg: 'User not found. Please sign up.');
        print('No user found with email: $uemail');
        return;
      }
      print('Stored Password in DB: "${user.password}"');
      print('Entered Password: "$upassword"');

      // Fix password check
      if (user.password == upassword) {
        // Compare with input password
        SharedPreferences sp = await SharedPreferences.getInstance();
        await sp.setString('userEmail', user.email?? "Unknown");


        Fluttertoast.showToast(msg: 'Login Successful!');
        await dbHelper.printTableData();
        print('User logged in: ${user.email}');

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationbar()),
          (route) => false,
        );
      } else {
        Fluttertoast.showToast(msg: 'Invalid Email or Password. Try again!');
        print('Incorrect password for user: $uemail');
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error: ${error.toString()}');
      print('Error during login: $error');
    }
  }

  // validation email or pass
  // String? validateEmail(String? email){
  //   RegExp emailRegex = RegExp( r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   final isEmailValid = emailRegex.hasMatch(email ?? '');
  //   if(!isEmailValid){
  //     return 'Please Enter Valid Email';
  //   }
  //   return null;
  // }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      //   centerTitle: true,
      // ),

      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  color: Colors.brown.shade500),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 35,
              children: [
                Form(
                    key:_formkey,
                    child: Column(
                  spacing: 35,
                  children: [
                    CustomTextfield(hintText: 'Email', controller: Email, icon: Icons.email,
                      validator: (value){if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter valid email';
                    }
                    return null;
                    },),
                    CustomTextfield(
                      hintText: 'Password',
                      controller: Password,
                      icon: Iconsax.lock5,
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
                          return 'Password must contain letters and numbers';
                        }
                        return null;
                      },

                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ), onSuffixIconPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    ),

                  ],
                )),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      onPressed:() {
                        if (_formkey
                            .currentState!.validate()) ;
                        login(); },
                      // Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationbar()));

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade100,
                        minimumSize: Size(230, 50),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.brown.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.brown.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

