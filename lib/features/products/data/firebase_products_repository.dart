import 'package:clot/features/products/domain/category.dart';
import 'package:clot/features/products/domain/product.dart';
import 'package:clot/features/products/domain/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProductsRepository implements ProductRepository {
  final FirebaseFirestore _firestore;

  FirebaseProductsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Category>> getCategories() async {
    try {
      final snapshot = await _firestore
          .collection('categories')
          .orderBy('order')
          .get();
      return snapshot.docs
          .map((doc) => Category.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
  Future<Category?> getCategoryById(String id) async {
    try {
      final doc = await _firestore.collection('categories').doc(id).get();

      if (doc.exists) {
        return Category.fromMap(doc.data()!, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to fetch category: $e');
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      // Get all categories first
      final categories = await getCategories();

      List<Product> allProducts = [];

      // Fetch products from each category collection
      for (var category in categories) {
        final categoryId = category.id.trim();
        final categoryProducts = await getProductsByCategory(categoryId);
        allProducts.addAll(categoryProducts);
      }

      // Sort by creation date
      allProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return allProducts;
    } catch (e) {
      throw Exception('Failed to fetch all products: $e');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      print('Fetching products for category: $categoryId');

      final snapshot = await _firestore
          .collection(categoryId.trim())
          .orderBy('createdAt', descending: true)
          .get();

      print('Found ${snapshot.docs.length} products in $categoryId');

      return snapshot.docs
          .map((doc) => Product.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products by category: $e');
    }
  }

  @override
  Future<Product?> getProductById(String productId) async {
    try {
      final categories = await getCategories();

      for (var category in categories) {
        final categoryId = category.id.trim();
        final doc = await _firestore
            .collection(categoryId)
            .doc(productId)
            .get();

        if (doc.exists) {
          return Product.fromMap(doc.data()!, doc.id);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }
}
