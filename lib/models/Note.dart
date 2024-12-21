class FearRoom {
  final String title;
  final String description;
  final String imageUrl;
  final String fullInfo;
  final String type;
  final int cost;
  int amount;
  bool isFavorite;

  FearRoom({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.fullInfo,
    required this.type,
    required this.cost,
    this.amount = 0,
    this.isFavorite = false,
  });
}
