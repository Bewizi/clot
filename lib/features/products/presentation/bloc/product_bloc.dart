import 'package:clot/features/products/domain/category.dart';
import 'package:clot/features/products/domain/product.dart';
import 'package:clot/features/products/domain/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(ProductInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<LoadAllProducts>(_onLoadAllProducts);
    on<LoadProductById>(_onLoadProductById);
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

  Future<void> _onLoadAllProducts(
    LoadAllProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getAllProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to load products: $e'));
    }
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getProductsByCategory(
        event.categoryId,
      );
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to load products: $e'));
    }
  }

  Future<void> _onLoadProductById(
    LoadProductById event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final product = await _productRepository.getProductById(event.productId);
      if (product != null) {
        emit(ProductDetailsLoaded(product));
      } else {
        emit(ProductError('Product not found'));
      }
    } catch (e) {
      emit(ProductError('Failed to load product: $e'));
    }
  }
}
