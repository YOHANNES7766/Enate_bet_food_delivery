class CartItem {
  final String name;
  final double price;
  int quantity;
  final String image;
  final String description;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.description,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    String? name,
    double? price,
    int? quantity,
    String? image,
    String? description,
  }) {
    return CartItem(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }
}
