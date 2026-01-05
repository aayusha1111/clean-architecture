import 'package:clean_architecture/core/theme/theme_bloc.dart';
import 'package:clean_architecture/core/theme/theme_event.dart';
import 'package:clean_architecture/core/theme/theme_state.dart';
import 'package:clean_architecture/features/product/domain/entity/product_entity.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_bloc.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_event.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  Future<void> fetchProducts() async {
    if (!mounted) return;
    context.read<ProductBloc>().add(FetchProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return ToggleButtons(
                  isSelected: [
                    // themeController.value == ThemeMode.light,
                    // themeController.value == ThemeMode.dark,
                    state.themeMode == ThemeMode.light,
                    state.themeMode == ThemeMode.dark,
                  ],
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.light_mode),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.dark_mode),
                    ),
                  ],
                  onPressed: (index) {
                    if (index == 0) {
                      //themeController.setLight();
                      context.read<ThemeBloc>().add(SetLightTheme());
                    } else {
                      //themeController.setDark();
                      context.read<ThemeBloc>().add(SetDarkTheme());
                    }
                    setState(() {}); // updates the toggle UI
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoadedState) {
            return _ui(state.products);
          } else if (state is ProductErrorState) {
            return _errorOrEmptyUi(state.message);
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {
          if (state is ProductErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchProducts,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _ui(List<ProductEntity> products) {
    return products.isNotEmpty
        ? ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    product.image ?? 'https://via.placeholder.com/50',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title ?? ''),
                  subtitle: Text(
                    '\$${(product.price ?? 0.0).toStringAsFixed(2)}',
                  ),
                ),
              );
            },
          )
        : _errorOrEmptyUi('No products available');
  }

  Widget _errorOrEmptyUi(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: fetchProducts, child: const Text('Retry')),
      ],
    );
  }
}
