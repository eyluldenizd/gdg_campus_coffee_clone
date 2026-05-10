import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdg_campus_coffee/menu/data/model/product_model.dart';
import 'package:gdg_campus_coffee/menu/domain/entity/product.dart';
import 'package:gdg_campus_coffee/menu/domain/repository/i_product_repository.dart';

class ProductRepository implements IProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Product>> getProducts() async {
    try {
      final snapshot = await _firestore.collection('Menu').get();
      if (snapshot.docs.isEmpty) {
        print("Firestore collection 'Menu' returned no documents.");
      }

      final models = snapshot.docs.map((doc) {
        final data = doc.data();
        if (data is Map<String, dynamic>) {
          return ProductModel.fromFirestore(data);
        }
        print("Firestore document '${doc.id}' returned unexpected data: $data");
        return ProductModel();
      }).toList();

      return models.map((model) => model.toEntity()).toList();
    } catch (e, st) {
      print("Firestore'dan ürünler çekilirken hata oluştu: $e\n$st");
      rethrow;
    }
  }
}
