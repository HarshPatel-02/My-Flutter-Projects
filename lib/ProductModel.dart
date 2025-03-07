class ProductDetail {
  List<Category>? category;

  ProductDetail({this.category});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    if (json['Category'] != null) {
      category = <Category>[];
      json['Category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['Category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? img;
  String? category;

  Category({this.img, this.category});

  Category.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['category'] = this.category;
    return data;
  }
}







// {
  //   "data":[
  //     {
  //     "img":"https://t4.ftcdn.net/jpg/05/03/32/35/360_F_503323522_qvU0AkmlnGXF2JyKYw0lPHsBJ27jRBtH.jpg",
  //     "category":"Bedroom"
  //     },
  //     {
  //     "img":"https://cdn-icons-png.flaticon.com/256/13139/13139120.png",
  //     "category":"Bedroom"
  //     },
  //     {
  //     "img":"https://cdn-icons-png.flaticon.com/256/333/333447.png",
  //     "category":"Bath"
  //     },
  //     {
  //     "img":"https://cdn-icons-png.flaticon.com/256/3567/3567197.png",
  //     "category":"Dinning"
  //     },
  //     {
  //     "img":"https://cdn-icons-png.flaticon.com/256/1606/1606657.png",
  //     "category":"Kitchen"
  //     }
  //
  // ]
  // }
