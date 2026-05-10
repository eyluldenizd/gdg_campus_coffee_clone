import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdg_campus_coffee/market/data/model/catalog_product_model.dart';
import 'package:gdg_campus_coffee/market/domain/entity/catalog_product.dart';
import 'package:gdg_campus_coffee/market/domain/repository/i_market_repository.dart';

class MarketRepository implements IMarketRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<CatalogProduct>> getCatalogProducts() async {
    try {
      final snapshot = await _firestore.collection('market').get();
      if (snapshot.docs.isEmpty) {
        print("Firestore collection 'market' returned no documents.");
      }

      final models = snapshot.docs.map((doc) {
        final data = doc.data();
        if (data is Map<String, dynamic>) {
          return CatalogProductModel.fromFirestore(data);
        }
        print("Firestore document '${doc.id}' returned unexpected data: $data");
        return CatalogProductModel();
      }).toList();

      return models.map((model) => model.toEntity()).toList();
    } catch (e, st) {
      print("Firestore'dan market ürünleri çekilirken hata oluştu: $e\n$st");
      rethrow;
    }
  }
}
