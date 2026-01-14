import 'package:clot/features/products/domain/category.dart';
import 'package:clot/features/products/domain/product.dart';

abstract class ProductRepository {
  Future<List<Category>> getCategories();

  Future<Category?> getCategoryById(String id);

  Future<List<Product>> getAllProducts();

  Future<List<Product>> getProductsByCategory(String categoryId);

  Future<Product?> getProductById(String id);
}
