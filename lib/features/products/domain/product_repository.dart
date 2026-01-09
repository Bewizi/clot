import 'package:clot/features/products/domain/category.dart';

abstract class ProductRepository {
  Future<List<Category>> getCategories();
  Future<Category?> getCategoryById(String id);
}
