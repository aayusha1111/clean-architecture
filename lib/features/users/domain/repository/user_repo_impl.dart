import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/users/data/datasoucres/user_remote_datasources.dart';
import 'package:clean_architecture/features/users/data/model/user_model.dart';
import 'package:clean_architecture/features/users/domain/entity/user_entity.dart';
import 'package:clean_architecture/features/users/domain/repository/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDatasource datasource;
  final NetworkInfo networkInfo;
  UserRepoImpl(this.datasource, this.networkInfo);
  @override
  Future<Either<Failure, String>> postUser(UserEntity user) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure("No Internet Connection"));

    try {
      final model = UserModel(
        username: user.username,
        email: user.email,
        password: user.password,
      );
      final response = await datasource.postUser(model);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure('$e'));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> fetchUsers() async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure("No Internet Connection"));

    try {
      final response = await datasource.fetchUsers();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure('$e'));
    }
  }

  @override
Future<Either<Failure, String>> updateUser(UserEntity user) async {
  final isConnected = await networkInfo.isConnected;
  if (!isConnected) {
    return Left(NetworkFailure("No Internet Connection"));
  }

  try {
    final model = UserModel.fromEntity(user);
    final response = await datasource.updateUser(model);
    return Right(response);
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

  
 
  }

