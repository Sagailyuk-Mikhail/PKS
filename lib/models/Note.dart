class FearRoom {
  final String title;
  final String description;
  final String imageUrl;
  final String fullInfo;
  final String type;
  bool isFavorite;

  FearRoom({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.fullInfo,
    required this.type,
    this.isFavorite = false,
  });
}
