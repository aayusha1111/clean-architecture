import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entity/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure,List<ProductEntity>>> fetchProducts();
}