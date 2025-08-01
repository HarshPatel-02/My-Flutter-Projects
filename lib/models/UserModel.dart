// class UserModel {
//   int? id;
//    String email;
//    String password;
//
//   UserModel({this.id, required this.password, required this.email});
//
//
//
//   factory UserModel.fromMap(Map<String, dynamic> map){
//     return UserModel(
//         id : map['id'] as int,
//         email : map['email'] ??'',
//         password : map['password'] ?? '',
//     );
//   }
//   Map<String, dynamic> toMap() {
//     return {'id': id,'email': email,'password': password,};
//   }
// }


class UserModel {
  int? id;
  String email;
  String password;

  UserModel({required this.email, required this.password,this.id});

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'Email': email,
      'Password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['Email'],
      password: map['Password'],
    );
  }
}