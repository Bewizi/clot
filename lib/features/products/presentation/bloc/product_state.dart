part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class CategoryLoading extends ProductState {}

final class CategoriesLoaded extends ProductState {
  final List<Category> categories;

  CategoriesLoaded(this.categories);
}

final class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
