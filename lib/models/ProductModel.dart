// class BedRoom {
//   List<BedRoomElement> bedRoom;
//
//   BedRoom({
//     required this.bedRoom,
//   });
//
// }

class ProductItem {
  int id;
  int? userId;
  String img;
  String category;
  String title;
  String price;
  String rating;
  String description;
  int qty;

  ProductItem({
    required this.id,
    this.userId,
    required this.img,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.description,
    this.qty=1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userId': userId,
      'img': this.img,
      'category': this.category,
      'title': this.title,
      'price': this.price,
      'rating': this.rating,
      'description': this.description,
      'qty': this.qty,
    };
  }

  factory ProductItem.fromMap(Map<String, dynamic> map) {
    return ProductItem(
      id: (map['id'] as int),
      userId: map['userId'],
      img: map['img'] as String,
      category: map['category'] as String,
      title: map['title'] as String,
      price: map['price'] as String,
      rating: map['rating'] as String,
      description: map['description'] as String,
      qty: map['qty'] ??1 as int,

    );
  }
  @override
  String toString() {
    return '(Title :$title,Price: $price,)';
  }


}







// {
// "BedRoom": [
// {
// "img": "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg",
// "category": "Bedroom",
// "price": "$200.00",
// "rating": "3.6"
// },
// {
// "img": "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg",
// "category": "Bedroom",
// "price": "$200.00",
// "rating": "4.1"
// },
// {
// "img": "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg",
// "category": "Bedroom",
// "price": "$250.00",
// "rating": "3.9"
// },
// {
// "img": "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg",
// "category": "Bedroom",
// "price": "$250.00",
// "rating": "4.7"
// },
// {
// "img": "https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg",
// "category": "Bedroom",
// "price": "$300.00",
// "rating": "5.0"
// },
// {
// "img": "https://i.pinimg.com/236x/67/01/6a/67016a346050ce6bf8e872b098a280ff.jpg",
// "category": "Bedroom",
// "price": "$300.00",
// "rating": "4.6"
// },
// {
// "img": "https://i.pinimg.com/474x/8e/ff/6c/8eff6c3635847fc59449975ea7b0b25d.jpg",
// "category": "Bedroom",
// "price": "$350.00",
// "rating": "5.0"
// },
// {
// "img": "https://i.pinimg.com/236x/d6/ca/df/d6cadfcad8fb1249ed913c026b3f6527.jpg",
// "category": "Bedroom",
// "price": "$350.00",
// "rating": "4.2"
// },
// {
// "img": "https://i.pinimg.com/474x/c7/b1/75/c7b17545c8259bde6ac586547643efe1.jpg",
// "category": "Bedroom",
// "price": "$400.00",
// "rating": "3.8"
// },
// {
// "img": "https://i.pinimg.com/236x/8b/9f/53/8b9f53fb3422155d692965b17e01ea3f.jpg",
// "category": "Bedroom",
// "price": "$400.00",
// "rating": "4.6"
// },
// {
// "img": "https://i.pinimg.com/236x/14/46/e6/1446e6622ca5c8e5ebb3800fa7c7adad.jpg",
// "category": "Bedroom",
// "price": "$450.00",
// "rating": "4.6"
// },
// {
// "img": "https://i.pinimg.com/236x/c3/45/e9/c345e93088616d20d601341432a406b0.jpg",
// "category": "Bedroom",
// "price": "$450.00",
// "rating": "4.2"
// },
// {
// "img": "https://i.pinimg.com/236x/23/dd/0b/23dd0b36daf1da11e4179f35002a11a0.jpg",
// "category": "Bedroom",
// "price": "$500.00",
// "rating": "4.3"
// },
// {
// "img": "https://i.pinimg.com/236x/d5/b2/03/d5b20325cd5ff3004421fc7192672c2e.jpg",
// "category": "Bedroom",
// "price": "$500.00",
// "rating": "5.0"
// }
// ]
// }
