import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/product/data/datasources/product_datasource.dart';
import 'package:clean_architecture/features/product/domain/entity/product_entity.dart';
import 'package:clean_architecture/features/product/domain/repository/product_repo.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository{
  final ProductDatasource datasource;
  final NetworkInfo networkInfo;
  ProductRepositoryImpl(this.datasource,this.networkInfo);
  @override
  Future<Either<Failure,List<ProductEntity>>>fetchProducts()async{
    bool isConnected=await networkInfo.isConnected;
    if(!isConnected)return Left(NetworkFailure("No internet Connection"));

    try{
      final response=await datasource.getProducts();
      return Right(response);
    } catch(e){
      return Left(ServerFailure('$e'));
    }
  }
}