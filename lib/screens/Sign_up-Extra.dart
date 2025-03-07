// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:task1/screens/getData.dart';
//
// import '../ui_widgets/custom_textfield.dart';
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   List<String> items= <String>[
//     'Male',
//     'Female'
//   ];
//   String dropdownValue ='Male';
//
//   // TextEditingController firstnameController =TextEditingController();
//   // TextEditingController lastnameController =TextEditingController();
//   TextEditingController UsernameController =TextEditingController();
//   TextEditingController emailController =TextEditingController();
//   // TextEditingController dateofbirthController =TextEditingController();
//   // TextEditingController phonenoController =TextEditingController();
//   // String? dropdown = null;
//   // String dropdownValue ='Female';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//           title:Text('Signup'),centerTitle: true,
//           backgroundColor: Color(0xFFF9FF40),
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () { Scaffold.of(context).openDrawer(); },
//                 tooltip: MaterialLocalizations.of(context).backButtonTooltip,
//               );
//             },
//           )
//
//
//       ),
//
//       body: Container(
//
//
//         width: double.infinity,
//         child: SingleChildScrollView(
//
//           padding: EdgeInsets.symmetric(horizontal: 16,vertical: 36),
//           child: Column(
//               spacing: 20,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children:[
//
//
//
//                 // ClipRRect(
//                 //   child: Image.asset('assets/profile.png',fit: BoxFit.fill,width: 140,height: 140,),
//                 //     borderRadius: BorderRadius.circular(140),),
//                 // const SizedBox(height: 30),
//
//                 // CustomContainer(containerText: 'this is '),   //custom container in text property
//
//                 // CustomTextfield(hintText: 'FirstName', controller: firstnameController),
//                 // // const SizedBox(height: 20),
//                 //
//                 // CustomTextfield(hintText: 'Last Name', controller: lastnameController),
//
//                 CustomTextfield(hintText: 'UserName', controller: UsernameController),
//
//                 CustomTextfield(hintText: 'Email', controller: emailController,icon:Icons.email),
//                 // CustomTextfield(hintText: 'date Of Birth', controller: dateofbirthController,icon: Icons.date_range),
//                 // CustomTextfield(hintText: 'Phone Number', controller: phonenoController),
//
//
//
//
//                 // Center(
//                 //
//                 //   child: Container(
//                 //     width: double.infinity,
//                 //     // padding: EdgeInsets.symmetric(horizontal: 16),
//                 //     decoration: BoxDecoration(border: Border.all(
//                 //       color: Colors.grey,
//                 //       width: 1,
//                 //
//                 //     ),
//                 //
//                 //         borderRadius: BorderRadius.circular(12)),
//                 //
//                 //     child: DropdownButton<String>(
//                 //       padding: EdgeInsets.symmetric(horizontal: 16),
//                 //       borderRadius: BorderRadius.circular(10),
//                 //
//                 //       iconSize: 24,
//                 //       // menuMaxHeight: double.infinity,
//                 //       // menuWidth: double.infinity,
//                 //       onChanged:(String? newValue){
//                 //         dropdownValue = newValue!;
//                 //
//                 //         if(mounted)setState(() {});
//                 //       },
//                 //       elevation: 16,   // shadow pde
//                 //       isExpanded: true,
//                 //       underline: SizedBox.shrink(),
//                 //       value: dropdownValue,
//                 //       items: items.map<DropdownMenuItem<String>>(
//                 //             (String value){
//                 //           return DropdownMenuItem<String>(
//                 //             child: Text(value),
//                 //             value: value,
//                 //           );
//                 //         },
//                 //       ).toList(),
//                 //     ),
//                 //   ),
//                 // ),
//
//                 // Appbutton(buttonText: 'Continue',onlyBorderButton:true,pressAction: (){
//                 //   print("Click Detected");
//                 // },),
//
//                 ElevatedButton(onPressed: ()async{
//
//                   SharedPreferences sp = await SharedPreferences.getInstance();
//
//                   // sp.setString("firstname", firstnameController.text);
//                   // sp.setString("lastname", lastnameController.text);
//
//                   sp.setString("UserName", UsernameController.text);
//
//                   sp.setString("email", emailController.text);
//                   // sp.setString("dateofbirth", dateofbirthController.text);
//                   // sp.setString("mobileno", phonenoController.text);
//                   // sp.setString("gender", dropdownValue);
//
//                   // Navigator.pop(context);
//
//
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>getData()));
//
//                 },style: ElevatedButton.styleFrom(
//
//                   backgroundColor: Color(0xFFF9FF40),
//                   minimumSize: Size(200, 50),
//
//                 ),
//
//                   child:Text('Continue')
//                   ,)
//
//               ]
//           ),
//         ),
//       ),
//
//
//
//
//
//
//     );
//   }
// }
//
//
