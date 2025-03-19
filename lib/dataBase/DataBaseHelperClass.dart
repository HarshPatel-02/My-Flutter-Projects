// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:task1/models/UserModel.dart';
// import 'dart:io' as io;
//
// class DataBaseHelper{
//
//   static  Database? _db;
//
//   static const String DB_Decoze = 'decoze.db';
//   static const String Table_UserData = 'USERDATA';
//
//   static const String C_Email='Email';
//   static const String C_Password='Password';
//
//   Future<Database?> get db async{
//      if(_db !=null){
//        return _db;
//      }
//      _db = await initDatabase();
//      return _db;
//   }
//   initDatabase()async{
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, DB_Decoze);
//
//     // var db =await openDatabase(path,version: 1,onCreate: onCreate);
//     return await  openDatabase(path,version: 1,onCreate: onCreate);
//   }
//
//
//   Future<UserModel?> getUserByEmail(String email) async {
//     final database = await db;
//
//     if (database == null) {
//       print("Database is null");
//       return null;
//     }
//
//     List<Map<String, dynamic>> maps = await database.query(
//       Table_UserData,
//       where: '$C_Email= ?',
//       whereArgs: [email],
//     );
//
//     if (maps.isNotEmpty) {
//       var user = UserModel.fromMap(maps.first);
//       print('Retrieved User: ${user.email}, Password: ${user.password}');
//       return user;
//     }
//     else{
//       print("No user found with email: $email");
//       return null;
//     }
//
//   }
//
//   onCreate(Database db,int version)async{
//     await db.execute(
//         "CREATE TABLE  $Table_UserData (id INTEGER PRIMARY KEY AUTOINCREMENT,"
//             "$C_Email TEXT NOT NULL UNIQUE,"
//             "$C_Password TEXT NOT NULL)"
//     );
//     print("Table Created: $Table_UserData");
//   }
//   Future<int?> insert(UserModel usermodel)async{
//     var dbclient = await db;
//     try {
//       int id = await dbclient!.insert(Table_UserData, {
//         C_Email: usermodel.email,
//         C_Password: usermodel.password, // Ensure password is stored
//       });
//
//       print("Inserted User ID: $id, Email: ${usermodel.email}, Password: ${usermodel.password}");
//       return id;
//     } catch (e) {
//       if (e is DatabaseException && e.isUniqueConstraintError()) {
//         print("Error: Email '${usermodel.email}' already exists in the database.");
//         return null;
//       } else {
//         throw e;
//       }
//     }
//
//     return await dbclient!.insert(Table_UserData, {
//       C_Email: usermodel.email,
//       C_Password: usermodel.password, //
//     });
//
//   }
//
//   Future<void> deleteDatabaseFile() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'decoze.db');
//
//     await deleteDatabase(path);
//     print('🚀 Database deleted. Restart the app.');
//   }
//   Future<void> printAllUsers() async {
//     final database = await db;
//
//     List<Map<String, dynamic>> users = await database!.query(Table_UserData);
//
//     for (var user in users) {
//       print('User: ${user[C_Email]}, Password: ${user[C_Password]}');
//     }
//     }
//   }
//

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/models/UserModel.dart';
import 'dart:io' as io;

class DataBaseHelper {
  static Database? _db;

  static const String DB_NAME = 'decoze.db';
  static const String TABLE_USER = 'USERDATA';
  static const String C_EMAIL = 'Email';
  static const String C_PASSWORD = 'Password';

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
      print("🔍 User Found: ${maps.first}");
      return UserModel.fromMap(maps.first);
    } else {
      print("⚠️ No user found with email: $email");
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
//
// Future<void> deleteDatabaseFile() async {
//   io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//   String path = join(documentDirectory.path, DB_NAME);
//   await deleteDatabase(path);
//   print(' Database deleted. Restart the app.');
// }
}
