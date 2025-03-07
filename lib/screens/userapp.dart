// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:task1/screens/usermodel.dart';
//
// class Userapp extends StatefulWidget {
//   const Userapp({super.key});
//
//   @override
//   State<Userapp> createState() => _UserappState();
// }
//
// class _UserappState extends State<Userapp> {
//   Future<UserModel>fetchUser() async{
//
//     final url ="https://reqres.in/api/users?page=2";
//
//     var response= await http.get(Uri.parse(url));
//
//     if(response.statusCode==200)
//     {
//       final result =jsonDecode(response.body);
//       print("CHeckResponse:::${result}");
//       var x1= UserModel.fromJson(result);
//       print("CHeckResponse AFTER BINDING:::${x1.data!.first.toJson()}");
//       print("CheckUSERDATA::Length:${x1.data!.length}");
//       return x1;
//     }
//
//     else{
//       return UserModel();
//     }
//   }
//
//   @override
//   void initState() {
//      super.initState();
//      UserModel();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("User"),
//       ),
//     //   body:FutureBuilder(future: fetchUser(), builder: context,details){
//     //     return ListView.builder(itemBuilder: (context,index){
//     //       return ListTile(
//     //       title: Text("${details.data!.name![index].title}"),
//     //       subtitle: Text("${details.data!.name![index].title}")
//     //       );
//     // },itemCount: details.data!.name!.length,);
//     // }
//
//       body:FutureBuilder(future: fetchUser(), builder: (context, details) {
//         return ListView.builder(
//           itemCount: details.data!.data!.length,
//           itemBuilder:(context, index) {
//           // print(details.data!.data.first.name);
//           return ListTile(
//             title: Text("${details.data!.data![index].id!}"),
//                   subtitle: Text("${details.data!.data![index].name}")
//           );
//         },);
//       },)
//         ,
//
//     );
//   }
// }
