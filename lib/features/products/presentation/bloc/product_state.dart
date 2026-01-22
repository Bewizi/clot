part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class HomeDataLoaded extends ProductState {
  final List<Category> categories;
  final List<Product> topSellingProducts;
  final List<Product> newInProducts;
  final bool isCategoryLoading;
  final bool isTopSellingLoading;
  final bool isNewInLoading;

  HomeDataLoaded({
    required this.categories,
    required this.topSellingProducts,
    required this.newInProducts,
    this.isCategoryLoading = false,
    this.isTopSellingLoading = false,
    this.isNewInLoading = false,
  });

  HomeDataLoaded copyWith({
    List<Category>? categories,
    List<Product>? topSellingProducts,
    List<Product>? newInProducts,
    bool? isCategoryLoading,
    bool? isTopSellingLoading,
    bool? isNewInLoading,
  }) {
    return HomeDataLoaded(
      // CRITICAL: Keep existing data if not provided
      categories: categories ?? this.categories,
      topSellingProducts: topSellingProducts ?? this.topSellingProducts,
      newInProducts: newInProducts ?? this.newInProducts,
      isCategoryLoading: isCategoryLoading ?? this.isCategoryLoading,
      isTopSellingLoading: isTopSellingLoading ?? this.isTopSellingLoading,
      isNewInLoading: isNewInLoading ?? this.isNewInLoading,
    );
  }
}

final class ProductsLoaded extends ProductState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

final class ProductDetailsLoaded extends ProductState {
  final Product product;

  ProductDetailsLoaded(this.product);
}

final class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

final class TopSellingProductsLoaded extends ProductState {
  final List<Product> products;

  TopSellingProductsLoaded(this.products);
}

final class NewInProductsLoaded extends ProductState {
  final List<Product> products;

  NewInProductsLoaded(this.products);
}
