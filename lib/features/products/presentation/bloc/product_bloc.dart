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
    on<LoadTopSellingProducts>(_onLoadTopSellingProducts);
    on<LoadNewInProducts>(_onLoadNewInProducts);
  }

  HomeDataLoaded _getCurrentHomeState() {
    if (state is HomeDataLoaded) {
      return state as HomeDataLoaded;
    }
    return HomeDataLoaded(
      categories: [],
      topSellingProducts: [],
      newInProducts: [],
    );
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<ProductState> emit,
  ) async {
    // Get the LATEST state at emission time
    var currentState = _getCurrentHomeState();
    emit(currentState.copyWith(isCategoryLoading: true));

    try {
      final categories = await _productRepository.getCategories();

      // CRITICAL: Get state again AFTER async operation!
      currentState = _getCurrentHomeState();

      emit(
        currentState.copyWith(categories: categories, isCategoryLoading: false),
      );
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

  Future<void> _onLoadTopSellingProducts(
    LoadTopSellingProducts event,
    Emitter<ProductState> emit,
  ) async {
    var currentState = _getCurrentHomeState();
    emit(currentState.copyWith(isTopSellingLoading: true));

    try {
      final products = await _productRepository.getTopSellingProducts();

      // CRITICAL: Get state again AFTER async operation!
      currentState = _getCurrentHomeState();

      emit(
        currentState.copyWith(
          topSellingProducts: products,
          isTopSellingLoading: false,
        ),
      );
    } catch (e) {
      emit(ProductError('Failed to load top selling products: $e'));
    }
  }

  Future<void> _onLoadNewInProducts(
    LoadNewInProducts event,
    Emitter<ProductState> emit,
  ) async {
    var currentState = _getCurrentHomeState();
    emit(currentState.copyWith(isNewInLoading: true));

    try {
      final products = await _productRepository.getNewInProducts();

      // CRITICAL: Get state again AFTER async operation!
      currentState = _getCurrentHomeState();

      emit(
        currentState.copyWith(newInProducts: products, isNewInLoading: false),
      );
    } catch (e) {
      emit(ProductError('Failed to load new in products: $e'));
    }
  }
}
