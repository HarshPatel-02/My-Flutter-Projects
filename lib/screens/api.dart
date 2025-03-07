import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class api extends StatefulWidget {
  const api({super.key});

  @override
  State<api> createState() => _apiState();
}

class _apiState extends State<api> {

  void getRequest()async{
    //url
    var url =Uri.parse("https://reqres.in/api/users?page=2");

    var response = await http.get(url);
    print(response.body.toString());

  }

  void postRequest()async
  {
    var url=Uri.parse("https://reqres.in/api/login");
    var data ={
      "email": "eve.holt@reqres.in",
      "password": "cityslicka"
    };

    var response = await http.post(url,body: data);
    print(response.body.toString());
  }
  @override
  void initState() {
    // getRequest();
   postRequest();
    super.initState(

    );
  }



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
