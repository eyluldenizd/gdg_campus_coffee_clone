class CartItem {
  final String id;
  final String name;
  final String? description;
  final double? price;
  final int quantity;
  final String type; // 'menu' or 'market'

  CartItem({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.quantity = 1,
    required this.type,
  });

  CartItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? quantity,
    String? type,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      type: type ?? this.type,
    );
  }

  double get totalPrice => (price ?? 0) * quantity;
}
