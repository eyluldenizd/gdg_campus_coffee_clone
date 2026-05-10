import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdg_campus_coffee/recommendation/data/model/recommendation_model.dart';
import 'package:gdg_campus_coffee/recommendation/domain/entity/recommendation.dart';
import 'package:gdg_campus_coffee/recommendation/domain/repository/i_recommendation_repository.dart';

class RecommendationRepository implements IRecommendationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Recommendation>> getRecommendations() async {
    try {
      final snapshot = await _firestore.collection('recommendations').get();
      if (snapshot.docs.isEmpty) {
        print("Firestore collection 'recommendations' returned no documents.");
      }

      final models = snapshot.docs.map((doc) {
        final data = doc.data();
        if (data is Map<String, dynamic>) {
          return RecommendationModel.fromFirestore(data);
        }
        print("Firestore document '${doc.id}' returned unexpected data: $data");
        return RecommendationModel();
      }).toList();

      return models.map((model) => model.toEntity()).toList();
    } catch (e, st) {
      print("Firestore'dan öneriler çekilirken hata oluştu: $e\n$st");
      rethrow;
    }
  }
}
