import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/models/UserModel.dart';
import 'dart:io' as io;

class DataBaseHelper{

  static  Database? _db;

  static const String DB_Decoze = 'decoze.db';
  static const String Table_UserData = 'USERDATA';

  static const String C_Email='Email';
  static const String C_Password='Password';

  Future<Database?> get db async{
     if(_db !=null){
       return _db;
     }
     _db = await initDatabase();
     return _db;
  }
  initDatabase()async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_Decoze);

    // var db =await openDatabase(path,version: 1,onCreate: onCreate);
    return await  openDatabase(path,version: 1,onCreate: onCreate);
  }

  Future<UserModel?> getUserByEmailAndPassword(String email) async {
    final database = await db;
    List<Map<String, dynamic>> result = await database!.query(
      '$Table_UserData',
      where: '$C_Email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  onCreate(Database db,int version)async{
    await db.execute(
      "CREATE TABLE $Table_UserData (id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$C_Email TEXT NOT NULL,"
          "$C_Password TEXT NOT NULL)"
    );
  }
  Future<int> insert(UserModel usermodel)async{
    var dbclient = await db;

    return await dbclient!.insert('$Table_UserData',usermodel.toMap());

  }
}
