import 'package:clean_architecture/core/constant/api_const.dart';
import 'package:clean_architecture/core/network/api_client.dart';
import 'package:clean_architecture/features/users/data/datasoucres/user_remote_datasources.dart';
import 'package:clean_architecture/features/users/data/model/user_model.dart';
import 'package:dio/dio.dart';

class UserRemoteDatasourceImpl extends UserRemoteDatasource{
  final ApiClient apiClient;
  UserRemoteDatasourceImpl(this.apiClient);

  @override
  Future<String> postUser(UserModel model) async{
    try{
      final response=await apiClient.dio.post(
        ApiConst.baseUrl + ApiConst.users,
        data: model.toJson(),

      );
      if(response.statusCode==200 || response.statusCode==201){
        final String message=response.data['message'] ?? 'User created successfully';
        return message;
      }
      throw DioException(requestOptions: response.requestOptions);
    } catch(e){
      if(e is DioException){
        rethrow;
      }
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          data: {'message': e.toString()},
          requestOptions: RequestOptions(path: ''),
          statusCode: 0,
        ),
        type: DioExceptionType.unknown,
        error: '"inknownErrorString":${e.toString()}',
      );
    }
   
  }

  Future<List<UserModel>> fetchUsers() async{
    try{
      final response=await apiClient.dio.get(ApiConst.baseUrl + ApiConst.users);
     if (response.statusCode == 200 || response.statusCode == 201) {
      final data= response.data;
      if (data is Map && data.containsKey('users')) {
        final usersJson = data['users'] as List<dynamic>; // <-- fetch from map
        return usersJson.map((json) => UserModel.fromJson(json)).toList();
      } else if (data is List) {
        // <-- fallback if API returns list directly
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format'); // <-- NEW
      }
    } else {
      throw Exception('Failed to load users');
    }
    } catch(e){
      throw Exception('Failed to load users: $e');
    }

  }
  
  @override
  Future<String> updateUser(UserModel model) async {
    try{
      final response =await apiClient.dio.put('${ApiConst.baseUrl}${ApiConst.users}/${model.id}',
      data:model.toJson()
      );
      if (response.statusCode == 200) {
        return 'User updated successfully';
      }
      throw DioException(requestOptions: response.requestOptions);
    } catch(e){
      if(e is DioException){
        rethrow;
      }
      throw Exception(e.toString());
    }
    
  }

  

}