import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/usecase/usecase.dart';
import 'package:clean_architecture/features/product/domain/entity/product_entity.dart';
import 'package:clean_architecture/features/product/domain/repository/product_repo.dart';
import 'package:dartz/dartz.dart';

class FetchProductUsecase extends UseCase<List<ProductEntity>,NoParams>{
  final ProductRepository repository;
  FetchProductUsecase(this.repository);
  @override
  Future<Either<Failure,List<ProductEntity>>> call(NoParams params)async{
    return await repository.fetchProducts();
  }
 
}