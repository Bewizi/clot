part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

class CategoriesListLoaded extends CategoryState {
  final List<Category> categories;

  CategoriesListLoaded(this.categories);
}

class CategoryProductsLoaded extends CategoryState {
  final List<Product> products;
  final String categoryName;

  CategoryProductsLoaded(this.products, this.categoryName);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
