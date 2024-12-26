class AnalysisItem {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String fullInfo;
  final int cost;
  final String type;

  AnalysisItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.fullInfo,
    required this.cost,
    required this.type,
  });

  factory AnalysisItem.fromJson(Map<String, dynamic> json) {
    return AnalysisItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      fullInfo: json['fullInfo'],
      cost: json['cost'],
      type: json['type'],
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
    };
  }
}
