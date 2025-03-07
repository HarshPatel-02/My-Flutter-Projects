import 'package:flutter/material.dart';


class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favourite'),
      ),
      body:
      Center(
        child: Text('Comming Soon.....😁',style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
