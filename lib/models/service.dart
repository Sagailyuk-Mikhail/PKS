class ServiceModel {
  final String name;
  final String duration;
  final int price;
  bool isAdd;

  ServiceModel({
    required this.name,
    required this.duration,
    required this.price,
    this.isAdd = false,
  });
}
