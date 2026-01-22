part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class LoadCategories extends ProductEvent {}

class LoadAllProducts extends ProductEvent {}

class LoadProductsByCategory extends ProductEvent {
  final String categoryId;

  LoadProductsByCategory(this.categoryId);
}

class LoadFeaturedProducts extends ProductEvent {}

class LoadProductById extends ProductEvent {
  final String productId;

  LoadProductById(this.productId);
}

final class LoadTopSellingProducts extends ProductEvent {}

final class LoadNewInProducts extends ProductEvent {}
