import 'package:clot/features/products/domain/category.dart';
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
}
