import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/models/UserModel.dart';
import 'package:task1/screens/Bottom_navigationBar.dart';

import '../models/ProductModel.dart';

class DataBaseHelper {
  static Database? _db;

  static const String DB_NAME = 'decoze.db';
  static const String TABLE_USER = 'USERDATA';
  static const String C_EMAIL = 'Email';
  static const String C_PASSWORD = 'Password';

  // cartitem table
  static const String TABLE_CART = 'CART';

  static const String UC_ID = 'uc_id';
  static const String C_ID = 'id';
  static const String C_TITLE = 'title';
  static const String C_DESCRIPTION = 'description';
  static const String C_PRICE = 'price';
  static const String C_QTY = 'qty';
  static const String C_IMG = 'img';
  static const String C_CATEGORY = 'category';
  static const String C_RATING = 'rating';

  // fAV table
  static const String TABLE_FAVOURITE = 'FAVOURITE';

  static const String UF_ID = 'uf_id';
  static const String F_ID = 'id';
  static const String F_TITLE = 'title';
  static const String F_DESCRIPTION = 'description';
  static const String F_PRICE = 'price';
  static const String F_QTY = 'qty';
  static const String F_IMG = 'img';
  static const String F_CATEGORY = 'category';
  static const String F_RATING = 'rating';


  // New table for user profile
  static const String TABLE_PROFILE = 'USER_PROFILE';

  static const String P_USER_ID = 'user_id'; // Foreign key to USERDATA
  static const String P_FIRSTNAME = 'firstname';
  static const String P_LASTNAME = 'lastname';
  static const String P_EMAIL = 'email';
  static const String P_DOB = 'dateofbirth';
  static const String P_PHONE = 'phoneno';
  static const String P_GENDER = 'gender';
  static const String P_IMAGE = 'profile_image'; // Base64 string for image


  //order table
  static const String TABLE_ORDER = 'USER_ORDER';




  static final DataBaseHelper instance = DataBaseHelper._internal();

  DataBaseHelper._internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $TABLE_USER (id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_EMAIL TEXT NOT NULL UNIQUE, "
        "$C_PASSWORD TEXT NOT NULL)");

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $TABLE_CART (
        $UC_ID INTEGER, 
        $C_ID INTEGER PRIMARY KEY,
        $C_TITLE TEXT,
        $C_DESCRIPTION TEXT,
        $C_PRICE NUM,
        $C_CATEGORY TEXT,
        $C_RATING TEXT,
        $C_QTY INTEGER DEFAULT 1,
        $C_IMG String
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $TABLE_FAVOURITE (
        $UF_ID INTEGER,
        $F_ID INTEGER PRIMARY KEY,
        $F_TITLE TEXT,
        $F_DESCRIPTION TEXT,
        $F_PRICE NUM,
        $F_CATEGORY TEXT,
        $F_RATING TEXT,
        $F_QTY INTEGER DEFAULT 1,
        $F_IMG String
      )
    ''');

    await db.execute(''' 
     CREATE TABLE IF NOT EXISTS $TABLE_PROFILE ( 
     $P_USER_ID INTEGER PRIMARY KEY,
        $P_FIRSTNAME TEXT,
        $P_LASTNAME TEXT,
        $P_EMAIL TEXT,
        $P_DOB TEXT,
        $P_PHONE TEXT,
        $P_GENDER TEXT,
        $P_IMAGE String,
        FOREIGN KEY ($P_USER_ID) REFERENCES $TABLE_USER(id)
     )
    ''');


    await db.execute('''
    CREATE TABLE IF NOT EXISTS $TABLE_ORDER (
      O_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      product_id INTEGER,
      title TEXT,
      description TEXT,
      price NUM,
      category TEXT,
      rating REAL,
      quantity INTEGER DEFAULT 1,
      image String,
      datetime TEXT,
      FOREIGN KEY (user_id) REFERENCES $TABLE_USER(id)
    )
  ''');
    // await db.execute('''
    //     CREATE TABLE IF NOT EXISTS $TABLE_ORDER(
    //     $O_ID INTEGER PRIMARY KEY,
    //     $UC_ID INTEGER,
    //     $C_ID INTEGER ,
    //     $C_TITLE TEXT,
    //     $C_DESCRIPTION TEXT,
    //     $C_PRICE TEXT,
    //     $C_CATEGORY TEXT,
    //     $C_RATING TEXT,
    //     $C_QTY INTEGER DEFAULT 1,
    //     $C_IMG String
    // )''');

    print("----Database tables created successfully");
    print("----Table Created: $TABLE_USER,$TABLE_CART, $TABLE_FAVOURITE, $TABLE_PROFILE, $TABLE_ORDER");

  }

  Future<int?> insert(UserModel user) async {
    var dbClient = await db;
    try {
      // int id = await dbClient!.insert(TABLE_USER, user.toMap());
      return await dbClient!.insert(TABLE_USER, user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
      // ----- user id stored use  id
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setInt('user_id', id);

      // print(
      //     "Inserted User - ID: $id, Email: ${user.email}, Password: ${user.password}");
      // return id;
    } catch (e) {
      print("Error inserting user: ${e.toString()}");
      return null;
    }
  }

  // print all table name in sqlite
  Future<void> printAllTables() async {
    var dbClient = await db;
    List<Map<String, dynamic>> tables = await dbClient!.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");

    print("📋 Tables in Database:");
    for (var table in tables) {
      print("🔹 ${table['name']}");
    }
    await printAllTables();
  }

  // print table column in sqlite
  Future<void> printTableColumns(String tableName) async {
    var dbClient = await db;
    List<Map<String, dynamic>> columns =
        await dbClient!.rawQuery("PRAGMA table_info($tableName)");

    print("📌 Columns in Table: $tableName");
    for (var column in columns) {
      print("🔹 ${column['name']} (Type: ${column['type']})");
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final database = await db;

    if (database == null) {
      print("Database is null");
      return null;
    }

    List<Map<String, dynamic>> maps = await database.query(
      TABLE_USER,
      // columns: ['id'],
      where: '$C_EMAIL = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      UserModel user = UserModel.fromMap(maps.first);

      // 🔹 Save user ID in SharedPreferences
      await saveUserId(user.id!);
      print("User Found: ${maps.first}");
      return UserModel.fromMap(maps.first);
    } else {
      print(" No user found with email: $email");
      return null;
    }
  }

  Future<void> printAllUsers() async {
    final database = await db;
    List<Map<String, dynamic>> users = await database!.query(TABLE_USER);

    if (users.isEmpty) {
      print(" No users found in the database.");
    } else {
      for (var user in users) {
        print(' User: ${user[C_EMAIL]}, Password: "${user[C_PASSWORD]}"');
      }
    }
  }

  Future<void> printTableData()async{
    final database = await db;
    List<Map<String, dynamic>> users = await database!.query(TABLE_USER);

    // Print data
    for (var user in users) {
      print('----ID: ${user['id']}, Email: ${user['C_EMAIL']}, Password: ${user['C_PASSWORD']}');
    }
  }





//  database remove
// Future<void> deleteDatabaseFile() async {
//   io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//   String path = join(documentDirectory.path, DB_NAME);
//   await deleteDatabase(path);
//   print(' Database deleted. Restart the app.');
// }

  // Cart operations
  Future<int> addToCart(ProductItem product,int userId) async {
    try {
      final db = await this.db;

      // Retrieve logged-in user's ID
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');
      return await db!.insert(
        TABLE_CART,
        {
          UC_ID: userId,  // 🔹 Now storing user ID
          C_TITLE: product.title,
          C_DESCRIPTION: product.description,
          C_PRICE: product.price,
          C_CATEGORY: product.category,
          C_RATING: product.rating,
          C_QTY: product.qty,
          C_IMG: product.img.first,
        },
        // product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error adding to cart: $e");
      return 0;
    }
  }

  Future<List<ProductItem>> getCartItems(int userId) async {
    print("");
    try {
      final db = await this.db;

      // Retrieve logged-in user's ID
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');
      final List<Map<String, dynamic>> maps = await db!.query(
          TABLE_CART,
        where: '$UC_ID  = ?',  // 🔹 Fetch only this user's cart items
        whereArgs: [userId],

      );
      return List.generate(maps.length, (i) => ProductItem.fromMap(maps[i]));
    } catch (e) {
      print("Error getting cart items: $e");
      return [];
    }
  }


  Future<int> updateCartItem(ProductItem product) async {
    try {
      final db = await this.db;
      return await db!.update(
        TABLE_CART,
        {
          C_TITLE: product.title,
          C_DESCRIPTION: product.description,
          C_PRICE: product.price,
          C_CATEGORY: product.category,
          C_RATING: product.rating,
          C_QTY: product.qty,
          C_IMG: product.img.first,

        },
        where: '$C_ID = ?',
        whereArgs: [product.id],
      );
    } catch (e) {
      print("Error updating cart item: $e");
      return 0;
    }
  }

  Future<int> removeFromCart(int productId) async {
    try {
      final db = await this.db;
      return await db!.delete(
        TABLE_CART,
        where: '$C_ID = ?',
        whereArgs: [productId],
      );
    } catch (e) {
      print("Error removing from cart: $e");
      return 0;
    }
  }

  Future<int> clearCart(int userId) async {
    try {
      final db = await this.db;
      return await db!.delete(TABLE_CART,
        where: '$UC_ID = ?', // UC_ID is the user ID column in TABLE_CART
        whereArgs: [userId],);
    } catch (e) {
      print("Error clearing cart: $e");
      return 0;
    }
  }


  // save user data
  Future<void> saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

// removw data
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('user_id');
    await prefs.setBool('isLoggedIn', false); // is stored user in remove in sp
  }

  // save payment is successful
  Future<void> saveCartToOrders(int userId) async {
    try {
      final db = await this.db;
      final cartItems = await getCartItems(userId);
      String orderDate = DateTime.now().toIso8601String();   // store date or time in order
      for (var item in cartItems) {
        await db!.insert(
          TABLE_ORDER,
          {
            'user_id': userId,
            'product_id': item.id,
            'title': item.title,
            'description': item.description,
            'price': item.price, // Convert to numeric
            'category': item.category,
            'rating': num.parse(item.rating), // Convert to numeric
            'quantity': item.qty,
            'image': item.img.first,
            'datetime':orderDate,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      print("Cart items saved to orders for user ID: $userId");
    } catch (e) {
      print("Error saving cart to orders: $e");
      rethrow;
    }
  }

  Future<List<ProductItem>> getOrderItems(int userId) async {
    print("----OrderItems");
    try {
      print("OrderFetchingFOR USER:::::$userId");
      final db = await this.db;

      // Retrieve logged-in user's ID
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // int? userId = prefs.getInt('user_id');
      final List<Map<String, dynamic>> maps = await db!.query(
        TABLE_ORDER,
        where: 'user_id  = ?',  // 🔹 Fetch only this user's cart items
        whereArgs: [userId],
      );
      print("OrderFetching:${maps.first}");
      // {O_ID: 1, user_id: 1, product_id: 1, title: Stylish Dresser, description: A contemporary dresser with multiple storage compartments, crafted from high-quality wood to keep your bedroom organized in style., price: 250.0, category: Bedroom, rating: 4.7, quantity: 1, image: https://i.pinimg.com/236x/67/01/6a/67016a346050ce6bf8e872b098a280ff.jpg}
      return List.generate(maps.length, (i) => ProductItem(
        id: maps[i]['O_ID'],
        category: maps[i]['category'],
        description: maps[i]['description'],
        img: [maps[i]['image']as String],
        price:  maps[i]['price'],
        rating:  maps[i]['rating'].toString(),
        title: maps[i]['title'] ,
        qty:  maps[i]['quantity'],
        orderDate: maps[i]['datetime']

      ));
    } catch (e,s) {
      print("Error getting ORDER items: $e ____ $s");
      return [];
    }
  }



// Fav operations
//   Future<int> addToFav(ProductItem product,int userId) async {
//     try {
//       final db = await this.db;
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       int? userId = prefs.getInt('user_id');
//       return await db!.insert(
//         TABLE_FAVOURITE,
//         {
//           UF_ID: userId,  // 🔹 Now storing user ID
//           F_TITLE: product.title,
//           F_DESCRIPTION: product.description,
//           F_PRICE: product.price,
//           F_CATEGORY: product.category,
//           F_RATING: product.rating,
//           F_QTY: product.qty,
//           F_IMG: product.img,
//         },
//         // product.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     } catch (e) {
//       print("Error adding to cart: $e");
//       return 0;
//     }
//   }
  Future<int> addToFav(ProductItem product, int userId) async {
    try {
      final db = await this.db;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');

      // Check if the product is already in favorites
      final existingFav = await db!.query(
        TABLE_FAVOURITE,
        where: '$F_ID = ? AND $UF_ID = ?',
        whereArgs: [product.id, userId],
      );

      if (existingFav.isNotEmpty) {
        // Product already exists in favorites, return without adding
        print("Product already in favorites");
        return 0;
      }

      // Insert the product if it doesn't exist
      return await db.insert(
        TABLE_FAVOURITE,
        {
          UF_ID: userId,
          F_ID: product.id, // Ensure the ID is explicitly set
          F_TITLE: product.title,
          F_DESCRIPTION: product.description,
          F_PRICE: product.price,
          F_CATEGORY: product.category,
          F_RATING: product.rating,
          F_QTY: product.qty,
          F_IMG: product.img.first,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error adding to favorites: $e");
      return 0;
    }
  }

  Future<List<ProductItem>> getFavItems(int userId) async {
    try {
      final db = await this.db;
      // Retrieve logged-in user's ID
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');
      final List<Map<String, dynamic>> maps = await db!.query(
          TABLE_FAVOURITE,
        where: '$UF_ID  = ?',
        whereArgs: [userId],

      );
      return List.generate(maps.length, (i) => ProductItem.fromMap(maps[i]));
    } catch (e) {
      print("Error getting cart items: $e");
      return [];
    }
  }

  Future<int> updateFavItem(ProductItem product) async {
    try {
      final db = await this.db;
      return await db!.update(
        TABLE_FAVOURITE,
        product.toMap(),
        where: '$F_ID = ?',
        whereArgs: [product.id],
      );
    } catch (e) {
      print("Error updating cart item: $e");
      return 0;
    }
  }

  // Future<int> removeFromFav(int productId) async {
  //   try {
  //     final db = await this.db;
  //     return await db!.delete(
  //       TABLE_FAVOURITE,
  //       where: '$F_ID = ?',
  //       whereArgs: [productId],
  //     );
  //   } catch (e) {
  //     print("Error removing from cart: $e");
  //     return 0;
  //   }
  // }
  Future<int> removeFromFav(int productId) async {
    try {
      final db = await this.db;
      int result = await db!.delete(
        TABLE_FAVOURITE,
        where: '$F_ID = ?',
        whereArgs: [productId],
      );
      print("Removed $result items from favorites with ID: $productId");
      return result;
    } catch (e) {
      print("Error removing from favorites: $e");
      return 0;
    }
  }

  Future<int> clearFav() async {
    try {
      final db = await this.db;
      return await db!.delete(TABLE_FAVOURITE);
     } catch (e) {
      print("Error clearing cart: $e");
      return 0;
    }
  }

  // user profile data save or get
  Future<int> saveUserProfile(int userId, Map<String, dynamic> profileData) async {
    final dbClient = await db;
    return await dbClient!.insert(
      TABLE_PROFILE,
      {P_USER_ID: userId, ...profileData},
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if exists
    );
  }

  // Method to load user profile
  Future<Map<String, dynamic>?> getUserProfile(int userId) async {
    final dbClient = await db;
    final result = await dbClient!.query(
      TABLE_PROFILE,
      where: '$P_USER_ID = ?',
      whereArgs: [userId],
    );
    return result.isNotEmpty ? result.first : null;
  }


}
