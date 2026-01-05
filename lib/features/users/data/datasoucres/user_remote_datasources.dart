import 'package:clean_architecture/features/users/data/model/user_model.dart';

abstract class UserRemoteDatasource{
  Future<String> postUser(UserModel model);
  Future<List<UserModel>> fetchUsers();
  Future<String> updateUser(UserModel model);

}
