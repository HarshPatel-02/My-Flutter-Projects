// import 'ProductModel.dart';
//
// class CartModel {
//   List<ProductItem> id;
//   String img;
//   String category;
//   String title;
//   String price;
//   String rating;
//   String description;
//   int qty;
//
//   CartModel({
//     required this.id,
//     required this.img,
//     required this.title,
//     required this.category,
//     required this.price,
//     required this.rating,
//     required this.description,
//     this.qty=1,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id.map((item) => item.toMap()).toList(),
//       'img': this.img,
//       'category': this.category,
//       'title': this.title,
//       'price': this.price,
//       'rating': this.rating,
//       'description': this.description,
//       'qty': this.qty,
//     };
//   }
//
//   factory CartModel.fromMap(Map<String, dynamic> map) {
//     return CartModel(
//       id: (map['id'] as List).map((id) => ProductItem.fromMap(id)).toList(),
//
//       img: map['img'] as String,
//       category: map['category'] as String,
//       title: map['title'] as String,
//       price: map['price'] as String,
//       rating: map['rating'] as String,
//       description: map['description'] as String,
//       qty: map['qty'] as int,
//     );
//   }
// }