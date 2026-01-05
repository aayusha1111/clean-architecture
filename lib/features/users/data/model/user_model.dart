import 'package:clean_architecture/features/users/domain/entity/user_entity.dart';

class UserModel extends UserEntity{

  UserModel({super.id, super.username, super.email, super.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
  factory UserModel.fromEntity(UserEntity entity){
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      password: entity.password,
    );
  } 

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

}
