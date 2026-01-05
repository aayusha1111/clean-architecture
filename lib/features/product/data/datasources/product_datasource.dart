import 'package:clean_architecture/features/product/data/model/product_model.dart';

abstract class ProductDatasource {
  Future<List<ProductModel>> getProducts();
}