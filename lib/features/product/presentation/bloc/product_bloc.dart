import 'package:clean_architecture/core/usecase/usecase.dart';
import 'package:clean_architecture/features/product/domain/usecase/fetch_product_usecase.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_event.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProductUsecase fetchProductUsecase;
  ProductBloc(this.fetchProductUsecase) : super(const ProductInitialState()) {
    on<FetchProductsEvent>(_onFetchProductEvent);
  }
  void _onFetchProductEvent(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    final result = await fetchProductUsecase.call(NoParams());
    result.fold(
      (f) {
        emit(ProductErrorState(f.message));
      },
      (p) {
        emit(ProductLoadedState(p));
      },
    );
    try {} catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}
