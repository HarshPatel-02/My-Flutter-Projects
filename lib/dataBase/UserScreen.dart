import 'package:flutter/material.dart';
import 'package:task1/dataBase/DataBaseHelperClass.dart';
import 'package:task1/models/UserModel.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final DataBaseHelper dbHelper = DataBaseHelper();
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final database = await dbHelper.db;
    List<Map<String, dynamic>> maps = await database!.query(DataBaseHelper.TABLE_USER);

    setState(() {
      users = maps.map((userMap) => UserModel.fromMap(userMap)).toList();
    });
  }

  Future<void> deleteUser(String email) async {
    final database = await dbHelper.db;
    await database!.delete(DataBaseHelper.TABLE_USER, where: "Email = ?", whereArgs: [email]);

    setState(() {
      users.removeWhere((user) => user.email == email);
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User $email removed"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Users'),
        backgroundColor: Colors.brown.shade200,
      ),
      body: users.isEmpty
          ? Center(child: Text("No users found"))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(

              leading: Icon(Icons.person, color: Colors.brown.shade500),
              title: Text("Email: ${users[index].email}"),
              subtitle: Text("Password: ${users[index].password}"),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteUser(users[index].email),
              ),
            ),
          );
        },
      ),
    );
  }
}
