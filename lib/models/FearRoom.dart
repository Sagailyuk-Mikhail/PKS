class FearRoom {
  final int? id;
  final String title;
  final String description;
  final String imageUrl;
  final String fullInfo;
  final int cost;
  final String type;
  final bool isFavorite;

  FearRoom({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.fullInfo,
    required this.cost,
    required this.type,
    this.isFavorite = false,
  });

  factory FearRoom.fromJson(Map<String, dynamic> json) {
    return FearRoom(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      fullInfo: json['fullInfo'],
      cost: json['cost'],
      type: json['type'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'fullInfo': fullInfo,
      'cost': cost,
      'type': type,
      'isFavorite': isFavorite,
    };
  }
}
