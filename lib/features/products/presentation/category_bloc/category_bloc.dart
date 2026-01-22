import 'package:clot/features/products/domain/category.dart';
import 'package:clot/features/products/domain/product.dart';
import 'package:clot/features/products/domain/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductRepository _repository;

  CategoryBloc({required ProductRepository repository})
    : _repository = repository,
      super(CategoryInitial()) {
    on<LoadAllCategoriesForBrowsing>(_onLoadAllCategories);
    on<LoadCategoryProducts>(_onLoadCategoryProducts);
  }

  Future<void> _onLoadAllCategories(
    LoadAllCategoriesForBrowsing event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final categories = await _repository.getCategories();
      emit(CategoriesListLoaded(categories));
    } catch (e) {
      emit(CategoryError('Failed to load categories: $e'));
    }
  }

  Future<void> _onLoadCategoryProducts(
    LoadCategoryProducts event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final products = await _repository.getProductsByCategory(
        event.categoryId.trim(),
      );

      // Get category name
      final category = await _repository.getCategoryById(
        event.categoryId.trim(),
      );
      final categoryName = category?.name ?? 'Products';

      emit(CategoryProductsLoaded(products, categoryName));
    } catch (e) {
      emit(CategoryError('Failed to load products: $e'));
    }
  }
}
