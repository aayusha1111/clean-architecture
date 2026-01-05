import 'package:clean_architecture/features/product/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {
  const ProductInitialState();
}

class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

class ProductLoadedState extends ProductState {
  final List<ProductEntity> products;
  const ProductLoadedState(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String message;
  const ProductErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
