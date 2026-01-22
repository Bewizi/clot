import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String categoryId;
  final String imageUrl;
  final List<String> images;
  final String name;
  final String price;
  final DateTime createdAt;
  final bool isTopSelling;
  final bool isNewIn;
  final bool inStock;
  final bool isLike;
  final int salesCount;

  Product({
    required this.id,
    required this.categoryId,
    required this.imageUrl,
    required this.images,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.isTopSelling,
    required this.isNewIn,
    required this.inStock,
    required this.isLike,
    required this.salesCount,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      categoryId: map['categoryId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      isTopSelling: map['isTopSelling'] ?? false,
      isNewIn: map['isNewIn'] ?? false,
      inStock: map['inStock'] ?? false,
      isLike: map['isLike'] ?? false,
      salesCount: map['salesCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'images': images,
      'name': name,
      'price': price,
      'createdAt': Timestamp.fromDate(createdAt),
      'isTopSelling': isTopSelling,
      'isNewIn': isNewIn,
      'inStock': inStock,
      'isLike': isLike,
      'salesCount': salesCount,
    };
  }
}
