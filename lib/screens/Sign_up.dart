import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/dataBase/DataBaseHelperClass.dart';
import 'package:task1/models/UserModel.dart';
import 'package:task1/screens/Login.dart';
import 'package:task1/screens/getData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../dataBase/UserScreen.dart';
import '../ui_widgets/custom_textfield.dart';
import 'Bottom_navigationBar.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey= GlobalKey<FormState>();

  DataBaseHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DataBaseHelper.instance;
  }
  bool _obscureText = true;

 final TextEditingController PasswordController =TextEditingController();
 final TextEditingController emailController =TextEditingController();

 void signup()async{
   String uemail=emailController.text.trim();
   String upassword=PasswordController.text.trim();

   if(uemail.isEmpty){
     Fluttertoast.showToast(msg: 'Please Enter Email');
     return;
   }
   if(upassword.isEmpty){
   Fluttertoast.showToast(msg:'Please Enter Password');
      return;
   }
   UserModel? existingUser = await dbHelper!.getUserByEmail(uemail,);
   if (existingUser != null) {
     Fluttertoast.showToast(msg: 'User already exists. Please log in.');
     print('User already exists: ${existingUser.email}');
     return;
   }

     try {
       int? userId = await dbHelper!.insert(UserModel(email: uemail, password: upassword));

       if (userId != null) {
         Fluttertoast.showToast(msg: 'Signup Successful!');
         print('User added: $uemail');

         SharedPreferences sp = await SharedPreferences.getInstance();
         await sp.setString('userEmail', uemail);

         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
       } else {
         Fluttertoast.showToast(msg: 'Email already in use. Please use a different email.');
       }
     } catch (error) {
       Fluttertoast.showToast(msg: 'Error: ${error.toString()}');
       print('Error during signup: $error');
     }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          // title:Text('Signup'),centerTitle: true,
          // backgroundColor: Color(0xFFF9FF40),
        ),
      resizeToAvoidBottomInset: false,

      body: Center(

        child: SingleChildScrollView(

          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              spacing: 50,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[

            Text("Create your decoze account",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 45,color:Colors.brown.shade500),),
                Column(
                  spacing: 30,
                  children: [
                    Form(

                        key:_formkey,
                        child: Column(
                          spacing: 35,
                          children: [
                            CustomTextfield(hintText: 'Email', controller: emailController,icon:Icons.email,
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
                              controller: PasswordController,
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


                  ],
                ),


                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ElevatedButton(onPressed: (){
                    if (_formkey.currentState!.validate()) {
                      signup();
                    }
                  },style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.brown.shade100,
                    minimumSize: Size(230, 50),

                  ),

                    child:Text('Sign up',style: TextStyle(color: Colors.brown.shade700,fontWeight: FontWeight.bold,fontSize: 18 ),)
                    ,),
                ),
                  SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',style: TextStyle(color: Colors.brown.shade500,fontWeight: FontWeight.bold,fontSize: 16 ),),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    }, child: Text('Sign in',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16 ),))
                  ],
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => UsersScreen()),
                //
                //     );
                //   },
                //   child: Text('Show All Users'),
                // )

              ]
          ),
        ),
      ),
    );
  }
}


