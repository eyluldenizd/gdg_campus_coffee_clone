class Recommendation {
  final String? id;
  final String? name;
  final String? description;
  final String? reason;
  final double? price;
  final String? type; // 'menu' or 'market'

  Recommendation({
    this.id,
    this.name,
    this.description,
    this.reason,
    this.price,
    this.type,
  });
}
