// import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;
  final int order;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.order,
  });

  factory Category.fromMap(Map<String, dynamic> map, String docId) {
    return Category(
      id: map['id'] ?? docId,
      name: map['name'],
      imageUrl: map['imageUrl'],
      order: map['order'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'imageUrl': imageUrl, 'order': order};
  }
}
