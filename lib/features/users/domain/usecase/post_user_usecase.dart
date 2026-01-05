import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/usecase/usecase.dart';
import 'package:clean_architecture/features/users/domain/entity/user_entity.dart';
import 'package:clean_architecture/features/users/domain/repository/user_repo.dart';
import 'package:dartz/dartz.dart';

class PostUserUsecase extends UseCase<String,UserEntity>{
  final UserRepo repo;
  PostUserUsecase(this.repo);
  @override
  Future<Either<Failure, String>> call(UserEntity params) async{
    return await repo.postUser(params);
  }
}

class FetchUserUsecase extends UseCase<List<UserEntity>,NoParams>{
  final UserRepo repo;
  FetchUserUsecase(this.repo);
  
  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) {
    return repo.fetchUsers();
  }
}

class UpdateUserUsecase extends UseCase<String,UserEntity>{
  final UserRepo repo;
  UpdateUserUsecase(this.repo);
  @override
  Future<Either<Failure, String>> call(UserEntity params) async{
    return await repo.updateUser(params);
  }
}

