class ProductModel {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final bool in_favorites;
  final bool in_cart;
  ProductModel(
      {required this.id,
      this.price,
      this.oldPrice,
      this.discount,
      required this.image,
      required this.name,
      required this.in_cart,
      required this.in_favorites});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final int id = json['id'] as int;
    final dynamic price = json['price'] as dynamic;
    final dynamic oldPrice = json['old_price'] as dynamic;
    final dynamic discount = json['discount'] as dynamic;
    final String image = json['image'] as String;
    final String name = json['name'] as String;
    final bool in_favorites = json['in_favorites'] as bool;
    final bool in_cart = json['in_cart'] as bool;

    return ProductModel(
      id: id,
      image: image,
      name: name,
      in_cart: in_cart,
      in_favorites: in_favorites,
      price: price,
      oldPrice: oldPrice,
      discount: discount,
    );
  }
}
