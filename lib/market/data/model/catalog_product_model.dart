import 'package:gdg_campus_coffee/market/domain/entity/catalog_product.dart';

class CatalogProductModel {
  final String? name;
  final String? description;
  final double? price;
  final String? category;

  CatalogProductModel({this.name, this.description, this.price, this.category});

  CatalogProduct toEntity() {
    return CatalogProduct(
      name: name,
      description: description,
      price: price,
      category: category,
    );
  }

  // Firestore'dan veri okumak için
  factory CatalogProductModel.fromFirestore(Map<String, dynamic> data) {
    return CatalogProductModel(
      name: data['name'] as String?,
      description: data['description'] as String?,
      price: (data['price'] as num?)?.toDouble(),
      category: data['category'] as String?,
    );
  }

  // Firestore'a göndermek için
  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "category": category,
    };
  }
}
