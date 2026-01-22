part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class LoadAllCategoriesForBrowsing extends CategoryEvent {}

class LoadCategoryProducts extends CategoryEvent {
  final String categoryId;

  LoadCategoryProducts(this.categoryId);
}
