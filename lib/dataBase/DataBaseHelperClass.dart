
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/models/UserModel.dart';
import 'dart:io' as io;

import '../models/ProductModel.dart';

class DataBaseHelper {
  static Database? _db;

  static const String DB_NAME = 'decoze.db';
  static const String TABLE_USER = 'USERDATA';
  static const String C_EMAIL = 'Email';
  static const String C_PASSWORD = 'Password';

  // cartitem table
  static const String TABLE_CART = 'CART';

  static const String C_ID = 'id';
  static const String C_TITLE = 'title';
  static const String C_DESCRIPTION = 'description';
  static const String C_PRICE = 'price';
  static const String C_QTY = 'qty';
  static const String C_IMG = 'img';
  static const String C_CATEGORY = 'category';
  static const String C_RATING = 'rating';

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
      CREATE TABLE $TABLE_CART (
        $C_ID INTEGER PRIMARY KEY,
        $C_TITLE TEXT,
        $C_DESCRIPTION TEXT,
        $C_PRICE TEXT,
        $C_CATEGORY TEXT,
        $C_RATING TEXT,
        $C_QTY INTEGER DEFAULT 1,
        $C_IMG String
      )
    ''');

    print("Database tables created successfully");
    print("Table Created: $TABLE_USER");
  }

  Future<int?> insert(UserModel user) async {

    var dbClient = await db;
    try {
      int id = await dbClient!.insert(TABLE_USER,user.toMap());

      print("Inserted User - ID: $id, Email: ${user.email}, Password: ${user.password}");
      return id;
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
    List<Map<String, dynamic>> columns = await dbClient!.rawQuery("PRAGMA table_info($tableName)");

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
      where: '$C_EMAIL = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
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
//  database remove
// Future<void> deleteDatabaseFile() async {
//   io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//   String path = join(documentDirectory.path, DB_NAME);
//   await deleteDatabase(path);
//   print(' Database deleted. Restart the app.');
// }


  // Cart operations
  Future<int> addToCart(ProductItem product) async {
    try {
      final db = await this.db;
      return await db!.insert(
        TABLE_CART,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error adding to cart: $e");
      return 0;
    }
  }

  Future<List<ProductItem>> getCartItems() async {
    try {
      final db = await this.db;
      final List<Map<String, dynamic>> maps = await db!.query(TABLE_CART);
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
        product.toMap(),
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

  Future<int> clearCart() async {
    try {
      final db = await this.db;
      return await db!.delete(TABLE_CART);
    } catch (e) {
      print("Error clearing cart: $e");
      return 0;
    }
  }


}
