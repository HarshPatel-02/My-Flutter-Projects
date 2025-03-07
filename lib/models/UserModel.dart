class UserModel {
  final int? id;
  final String email;
  final String password;

  UserModel({this.id, required this.password, required this.email});

  Map<String, Object?> toMap() {
    return {'id': id,'email': email,'password': password,};
  }

  factory UserModel.fromMap(Map<String, dynamic> res){
    return UserModel(
        id : res['id'],
        email : res['email'],
        password : res['password'],
    );
  }
}
