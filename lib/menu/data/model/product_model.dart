import 'package:gdg_campus_coffee/menu/domain/entity/product.dart';

class ProductModel {
  final String? name;
  final String? description;
  final double? price;

  ProductModel({this.name, this.description, this.price});

  Product toEntity() {
    return Product(name: name, description: description, price: price);
  }

  // Firestore'dan veri okumak için bu metodu kullanırsınız
  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
      name: data['name'] as String?,
      description: data['description'] as String?,
      price: (data['price'] as num?)?.toDouble(),
    );
  }

  // Firestore'a göndermek için bu metodu kullanırsınız
  Map<String, dynamic> toFirestore() {
    return {"name": name, "description": description, "price": price};
  }
}
