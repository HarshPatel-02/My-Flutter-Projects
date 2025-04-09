// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../ui_widgets/custom_textfield.dart';
//
// class getData extends StatefulWidget {
//   const getData({super.key});
//
//   @override
//   State<getData> createState() => _getDataState();
// }
//
// class _getDataState extends State<getData> {
//   // Create controllers to show data in TextFields
//   TextEditingController firstnameController = TextEditingController();
//   TextEditingController lastnameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController dateofbirthController = TextEditingController();
//   TextEditingController phonenoController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();  // Load data from SharedPreferences
//   }
//
//   Future<void> loadData() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//
//     setState(() {
//       firstnameController.text = sp.getString("firstname") ?? '';
//       lastnameController.text = sp.getString("lastname") ?? '';
//       emailController.text = sp.getString("email") ?? '';
//       dateofbirthController.text = sp.getString("dateofbirth") ?? '';
//       phonenoController.text = sp.getString("mobileno") ?? '';
//       genderController.text = sp.getString("gender") ?? '';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Profile Details'),
//         backgroundColor: Colors.brown.shade200,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CustomTextfield(hintText: 'First Name', controller: firstnameController),
//             CustomTextfield(hintText: 'Last Name', controller: lastnameController),
//             CustomTextfield(hintText: 'Email', controller: emailController),
//             CustomTextfield(hintText: 'Date of Birth', controller: dateofbirthController),
//             CustomTextfield(hintText: 'Phone Number', controller: phonenoController),
//             CustomTextfield(hintText: 'Gender', controller: genderController),
//           ],
//         ),
//       ),
//     );
//   }
// }
