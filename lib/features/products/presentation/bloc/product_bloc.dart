import 'package:clot/features/products/domain/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clot/features/products/domain/category.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(ProductInitial()) {
    on<LoadCategories>(_onLoadCategories);
    // on<LoadProductsByCategory>(_onLoadProductsByCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<ProductState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final categories = await _productRepository.getCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(ProductError('Failed to load categories: $e'));
    }
  }

  // Future<void> _onLoadProductsByCategory(
  //   LoadProductsByCategory event,
  //   Emitter<ProductState> emit,
  // ) async {
  //   emit
  //   try {
  //     final category = await _productRepository.getCategoryById(
  //       event.categoryId,
  //     );
  //     emit(Pro(category!));
  //   } catch (e) {
  //     emit(ProductError('Failed to load products: $e'));
  //   }
  // }
}
