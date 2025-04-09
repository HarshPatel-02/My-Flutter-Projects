import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:task1/screens/Product_details.dart';

import '../dataBase/DataBaseHelperClass.dart';
import '../main.dart';
import '../models/ProductModel.dart';
import '../models/dataProvider.dart';


class Categorys extends StatefulWidget {
  final String category;
  const Categorys({super.key,required this.category});

  @override
  State<Categorys> createState() => _CategorysState();
}

class _CategorysState extends State<Categorys> {
  String selectedCategory = "All";
  final DataBaseHelper dbHelper = DataBaseHelper.instance;


  @override
  void initState() {
    selectedCategory = widget.category;
    if(myCat!=null){
      selectedCategory=myCat;
    }
    // TODO: implement initState
    super.initState();
    loadFavorites();
  }

  void loadFavorites() async {
    int userId = 1;
    favoriteProducts = await dbHelper.getFavItems(userId); // Fetch from SQLite
    setState(() {}); // Update UI
  }

  void _onRemoveFromFavorites(ProductItem product) {
    setState(() {
      Fluttertoast.showToast(msg: 'Remove favorite');
      favoriteProducts.remove(product);
    });
  }


  @override
  Widget build(BuildContext context) {


    // Filtering products based on selectedCategory
    final filteredProducts = selectedCategory == "All"
        ? globalProductList.toList()
        : globalProductList.where((product) => product.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Wrap(
              spacing: 8.0,
              children: [
                categoryButton("All", "All"),
                categoryButton("Bedroom", "Bedroom"),
                categoryButton("Bath", "Bath"),
                categoryButton("Living Room", "Living"),
                categoryButton("Kitchen", "Kitchen"),
                categoryButton("Dining", "Dining"),
              ],
            ),
            Divider(thickness: 2),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 10, childAspectRatio: 0.65),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  var product = filteredProducts[index];
                  return InkWell(onTap: ()async{

                    await Navigator.push(context, MaterialPageRoute(builder: (context) => new ProductDetails(id:filteredProducts[index].id
                    ),));
setState(() {
print('------------ Favourite List :$favoriteProducts');
});

                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.brown, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(

                                child: Image.asset(product.img.first,
                                    fit: BoxFit.fill, height: 165, width: 300),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton.filledTonal(
                                onPressed: () async {
                                  bool isFavorite = favoriteProducts.any((item) => item.id == product.id);

                                  if (isFavorite) {
                                    await dbHelper.removeFromFav(product.id);
                                    favoriteProducts.removeWhere((item) => item.id == product.id);
                                    Fluttertoast.showToast(msg: 'Favorite Removed', backgroundColor: Colors.red);
                                  } else {
                                    int userId = 1;
                                    await dbHelper.addToFav(product,userId);
                                    favoriteProducts.add(product);
                                    Fluttertoast.showToast(msg: 'Favorite Added', backgroundColor: Colors.green);
                                  }

                                  setState(() {});
                                },
                                icon: Icon(
                                  favoriteProducts.any((item) => item.id == product.id) ? Icons.favorite : Icons.favorite_border,
                                  color: favoriteProducts.any((item) => item.id == product.id) ? Colors.red : Colors.brown,
                                ),
                                tooltip: 'Favorite',
                                iconSize: 24,
                              )

                            ),
                          ],
                        ),
                        Text(product.category,
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.green)),
                        Text('\$${product.price}',
                            style:
                            TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                        Row(
                          children: [
                            Icon(Icons.star, size: 18, color: Colors.amber),
                            Text('4.6',
                                style:
                                TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String label, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedCategory = category;
          });
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 35),
          backgroundColor:
          selectedCategory == category ? Colors.brown.shade300 : Colors.white,
          foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
        ),
        child: Text(label),
      ),
    );
  }
}



