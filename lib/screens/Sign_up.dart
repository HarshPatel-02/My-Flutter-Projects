import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/dataBase/DataBaseHelperClass.dart';
import 'package:task1/models/UserModel.dart';
import 'package:task1/screens/Login.dart';
import 'package:task1/screens/getData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ui_widgets/custom_textfield.dart';
import 'Bottom_navigationBar.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DataBaseHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DataBaseHelper();
  }

 final TextEditingController PasswordController =TextEditingController();
 final TextEditingController emailController =TextEditingController();

 void signup()async{
   String uemail=emailController.text.trim();
   String upassword=PasswordController.text.trim();

   if(uemail.isEmpty){
     Fluttertoast.showToast(msg: 'Please Enter Username');
   }
   else if(upassword.isEmpty){
   Fluttertoast.showToast(msg:'Please Enter Email');

return;
   }
   UserModel? existingUser = await dbHelper!.getUserByEmailAndPassword(uemail,);
   if (existingUser != null) {
     Fluttertoast.showToast(msg: 'User already exists. Please log in.');
     return;
   }

   try{
     await dbHelper!.insert(UserModel(email: uemail,password: upassword));

     SharedPreferences sp =await SharedPreferences.getInstance();
     await sp.setString('userEmail', uemail);

     Fluttertoast.showToast(msg: 'Signup Successful!');

     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
   }catch(error){
     Fluttertoast.showToast(msg: 'Error ${error.toString()}');
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          // title:Text('Signup'),centerTitle: true,
          // backgroundColor: Color(0xFFF9FF40),
        ),

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
                    CustomTextfield(hintText: 'Email', controller: emailController,icon:Icons.email),
                    CustomTextfield(hintText: 'Password', controller: PasswordController,icon: Iconsax.user4,),

                  ],
                ),


                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ElevatedButton(onPressed: (){

                    dbHelper!.insert(
                      UserModel(email: 'hp@gmail.com',password: '123456789')
                    ).then((onValue){
                      print('Data added',);

                    }).onError((error,stackTrace){
                      print(error.toString());
                    });

                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationbar()));

                  },style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.brown.shade200,
                    minimumSize: Size(230, 50),

                  ),

                    child:Text('Sign up',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18 ),)
                    ,),
                ),
                  SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',style: TextStyle(color: Colors.brown.shade500,fontWeight: FontWeight.bold,fontSize: 16 ),),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    }, child: Text('Sign in',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16 ),))
                  ],
                )

              ]
          ),
        ),
      ),
    );
  }
}


