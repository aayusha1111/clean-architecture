import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/users/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  Future<Either<Failure,String>>postUser(UserEntity users);
  Future<Either<Failure, List<UserEntity>>> fetchUsers();
  Future<Either<Failure,String>> updateUser(UserEntity users);
}

