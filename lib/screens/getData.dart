import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/main.dart';

class getData extends StatefulWidget {
  const getData({super.key});

  @override
  State<getData> createState() => _getDataState();
}

class _getDataState extends State<getData> {

  String firstname='';
  String lastname='';
  String email='';
  String Username='';
  String dateofbirth='';
  String mobileno='';
  String gender='';


  Future<String> getData()async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    setState(() {

        firstname = sp.getString("firstname").toString();
        lastname = sp.getString("lastname").toString();
        Username = sp.getString("Username").toString();
        email = sp.getString("email").toString();
        dateofbirth = sp.getString("dateofbirth").toString();
        mobileno = sp.getString("mobileno").toString();
        gender = sp.getString("gender").toString();
        // sp.setString("cartItems", jsonEncode([
        //
        //   {"id":1,"qty":5},
        // ]));

    });
    return Username;
  }


  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Get Data'),
      ),
      body: Column(
        children: [
          Text(firstname),
          Text(lastname),
          Text(email),
          Text(dateofbirth),
          Text(mobileno),
          Text(gender),



    ],
      ),


    );
  }
}

