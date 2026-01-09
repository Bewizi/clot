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

  // factory Category.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return Category(
  //     id: doc.id,
  //     name: data['name'] ?? '',
  //     imageUrl: data['imageUrl'] ?? '',
  //     order: data['order'] ?? 0,
  //   );
  // }

  factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      id: id,
      name: map['name'],
      imageUrl: map['imageUrl'],
      order: map['order'],
    );
  }

  // Map<String, dynamic> toFirestore() {
  //   return {'name': name, 'imageUrl': imageUrl, 'order': order};
  // }

  Map<String, dynamic> toMap() {
    return {'name': name, 'imageUrl': imageUrl, 'order': order};
  }
}
