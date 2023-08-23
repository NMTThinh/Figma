class UserModel {

  String? id_number;
  String? user_name;
  String? phone_number;
  String? password;

  UserModel({this.user_name, this.id_number, this.phone_number, this.password});



  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_name': user_name,
      'id_number': id_number,
      'phone_number': phone_number,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    user_name = map['user_name'];
    id_number = map['id_number'];
    phone_number = map['phone_number'];
    password = map['password'];
  }
}