class ShopData {
  List<ShopItem> shopItems;

  ShopData({required this.shopItems});

  void addProduct(ShopItem p) {
    shopItems.add(p);
  }

  void removeProduct(ShopItem p) {
    shopItems.add(p);
  }
}

class ShopItem {
  String imageUrl;
  String? thumbnail;
  String title;
  double price;
  int quantity;

  ShopItem(
      {required this.imageUrl,
      required this.thumbnail,
      required this.price,
      required this.quantity,
      required this.title});
}
