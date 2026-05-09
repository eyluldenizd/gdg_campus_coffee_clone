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
      
      final models = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data());
      }).toList();

      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Hata durumunda boş liste dönebilir veya hatayı fırlatabilirsiniz
      print("Firestore'dan ürünler çekilirken hata oluştu: $e");
      return [];
    }
  }
}
