import 'package:gdg_campus_coffee/recommendation/domain/entity/recommendation.dart';

class RecommendationModel {
  final String? id;
  final String? name;
  final String? description;
  final String? reason;
  final double? price;
  final String? type;

  RecommendationModel({
    this.id,
    this.name,
    this.description,
    this.reason,
    this.price,
    this.type,
  });

  Recommendation toEntity() {
    return Recommendation(
      id: id,
      name: name,
      description: description,
      reason: reason,
      price: price,
      type: type,
    );
  }

  // Firestore'dan veri okumak için
  factory RecommendationModel.fromFirestore(Map<String, dynamic> data) {
    return RecommendationModel(
      id: data['id'] as String?,
      name: data['name'] as String?,
      description: data['description'] as String?,
      reason: data['reason'] as String?,
      price: (data['price'] as num?)?.toDouble(),
      type: data['type'] as String?,
    );
  }

  // Firestore'a göndermek için
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'reason': reason,
      'price': price,
      'type': type,
    };
  }
}
