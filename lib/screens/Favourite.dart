import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task1/main.dart';
import '../dataBase/DataBaseHelperClass.dart';
import '../models/ProductModel.dart';
import 'Product_details.dart';

class Favourite extends StatefulWidget {
  final List<ProductItem> favoriteProducts;
  final Function(ProductItem) onRemoveFromFavorites; // Add this line

  const Favourite({
    super.key,
    required this.favoriteProducts,
    required this.onRemoveFromFavorites, // Add this line
  });

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final DataBaseHelper dbHelper = DataBaseHelper.instance;

  @override
  void initState() {
    super.initState();
    // favoriteProducts = widget.favoriteProducts;
    _loadFavItems();
  }

  Future<void> _loadFavItems() async {
    try {
      int userId = 1;
      favoriteProducts = await dbHelper.getFavItems(userId);
      setState(() {});
    } catch (e) {
      print("Error loading cart items: $e");
    }
  }

  Future<void> _removeItem(int index) async {
    try {
      await dbHelper.removeFromFav(favoriteProducts[index].id);
      await _loadFavItems();
      setState(() {
      });// Refresh the list
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  // void _removeFromFavorites(ProductItem product) {
  //   setState(() {
  //     favoriteProducts.remove(product);
  //   });
  //   widget.onRemoveFromFavorites(product); // Call the callback function
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown.shade200,
      ),
      body: favoriteProducts.isEmpty
          ? Center(
        child: Text(
          'No favorites added yet!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(id: product.id),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product.img.first,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${product.rating}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async{
                        _removeItem(index);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}