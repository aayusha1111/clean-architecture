import 'package:clean_architecture/core/constant/api_const.dart';
import 'package:clean_architecture/core/network/api_client.dart';
import 'package:clean_architecture/features/product/data/datasources/product_datasource.dart';
import 'package:clean_architecture/features/product/data/model/product_model.dart';
import 'package:dio/dio.dart';

class ProductDatassourceImpl implements ProductDatasource {
  final ApiClient apiClient;
  ProductDatassourceImpl(this.apiClient);
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiClient.dio.get(
        ApiConst.baseUrl + ApiConst.productEndpoint,
      );
      if (response.statusCode == 200) {
        final List<ProductModel> products = [];
        for (var product in response.data) {
          products.add(ProductModel.fromJson(product));
        }
        return products;
      }
      throw DioException(requestOptions: response.requestOptions);
    } catch (e) {
      if (e is DioException) {
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
}
