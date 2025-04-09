import 'package:flutter/material.dart';
import '../models/ProductModel.dart'; // Assuming ProductItem is defined here
import '../models/dataProvider.dart';
import 'Product_details.dart'; // Assuming globalProductList is defined here
 // Import the ProductDetails screen

// SearchNotifier to manage search state
class SearchNotifier extends ChangeNotifier {
  String _query = '';
  List<ProductItem> _filteredProducts = globalProductList;
  List<String> _uniqueCategories = [];

  String get query => _query;
  List<ProductItem> get filteredProducts => _filteredProducts;
  List<String> get uniqueCategories => _uniqueCategories;

  void setQuery(String newQuery) {
    _query = newQuery;
    _updateFilteredProducts();
    notifyListeners();
  }

  void _updateFilteredProducts() {
    if (_query.isEmpty) {
      _filteredProducts = globalProductList; // Show all products if query is empty
    } else {
      _filteredProducts = globalProductList.where((product) {
        // Search by title or category
        return product.title.toLowerCase().contains(_query.toLowerCase()) ||
            product.category.toLowerCase().contains(_query.toLowerCase());
      }).toList();
    }

    // Update unique categories
    _updateUniqueCategories();
  }

  void _updateUniqueCategories() {
    // Extract unique categories from filtered products
    _uniqueCategories = _filteredProducts
        .map((product) => product.category) // Get all categories
        .toSet() // Convert to a Set to remove duplicates
        .toList(); // Convert back to a List
  }
}

// Search Widget
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchNotifier _searchNotifier = SearchNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search',style: TextStyle(color: Colors.brown
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Replace SearchBar with TextField
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(color: Colors.brown.shade500, width: 1.6)),
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.brown.shade200, width: 1.6),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              cursorColor: Colors.brown, // Change the cursor color here
              onChanged: (value) {
                _searchNotifier.setQuery(value);
              },

            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedBuilder(
                animation: _searchNotifier,
                builder: (context, child) {
                  return ListView.builder(
                    itemCount: _searchNotifier.uniqueCategories.length,
                    itemBuilder: (context, index) {
                      final category = _searchNotifier.uniqueCategories[index];
                      return ExpansionTile(
                        title: Text(
                          category,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        children: _searchNotifier.filteredProducts
                            .where((product) => product.category == category)
                            .map((product) {
                          return ListTile(
                            leading: Image.network(
                              product.img.first,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(product.title),
                            subtitle: Text('\$${product.price}'),
                            trailing: Text('Rating: ${product.rating}'),
                            onTap: () {
                              // Navigate to ProductDetails screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    id: product.id,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'Category.dart';
// import '../models/dataProvider.dart';
//
// class Search extends StatefulWidget {
//   const Search({super.key});
//
//   @override
//   State<Search> createState() => _SearchState();
// }
//
// class _SearchState extends State<Search> {
//   String selectedCategory = "All";
//
//
//   @override
//   Widget build(BuildContext context) {
//     final filteredProducts = selectedCategory == "All"
//         ? globalProductList.toList()
//         : globalProductList.where((product) => product.category == selectedCategory).toList();
//
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Search'),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(child:Container(
//                   decoration: BoxDecoration(color: Colors.brown.shade200,borderRadius: BorderRadius.circular(50)),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       border: InputBorder.none,
//                       prefixIcon: Icon(Icons.search),
//                       suffixIcon: InkWell(onTap: () {
//
//                       },
//                           child: Icon(Iconsax.setting_4,color: Colors.brown,))
//                     ),
//                   ),
//                 )),
//               ],
//             ),
//             SizedBox(height: 50,),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Top Result',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.brown.shade600),),
//                 SizedBox(height: 20,),
//                 Wrap(
//                   spacing: 8.0,
//                   children: [
//                     categoryButton("All", "All"),
//                     categoryButton("Bedroom", "Bedroom"),
//                     categoryButton("Bath", "Bath"),
//                     categoryButton("Living Room", "Living"),
//                     categoryButton("Kitchen", "Kitchen"),
//                     categoryButton("Dining", "Dining"),
//
//                   ],
//                 ),
//               ],
//             )
//
//           ],
//         ),
//
//       ),
//     );
//   }
//   Widget categoryButton(String label, String category) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       child: OutlinedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>Categorys(category: category),
//             ),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           minimumSize: Size(100, 35),
//           backgroundColor:
//           selectedCategory == category ? Colors.brown.shade200 : Colors.brown.shade200,
//           foregroundColor:
//           selectedCategory == category ? Colors.black : Colors.black,
//         ),
//         child: Text(label),
//       ),
//     );
//   }
//
// }
