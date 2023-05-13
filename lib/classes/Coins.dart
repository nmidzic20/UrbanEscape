class Coin {
  Coin(this.id, this.amount, this.price, this.image_url);

  final int id;
  final int amount;
  final int price;
  final String image_url;
}

List<Coin> coins = [
  Coin(1, 300, 7, "assets/images/coinv1.png"),
  Coin(2, 700, 22, "assets/images/coinv2.png"),
  Coin(3, 1100, 45, "assets/images/coinv3.png"),
  Coin(4, 2100, 79, "assets/images/coinv4.png"),
];
