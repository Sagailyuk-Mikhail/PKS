class CartHistoryItem {
  final int cartId;
  final int countAnalyze;
  final int totalCost;

  CartHistoryItem({
    required this.cartId,
    required this.countAnalyze,
    required this.totalCost,
  });

  factory CartHistoryItem.fromJson(Map<String, dynamic> json) {
    return CartHistoryItem(
      cartId: json['cart_id'],
      countAnalyze: json['count_analyze'],
      totalCost: json['total_cost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartId,
      'count_analyze': countAnalyze,
      'total_cost': totalCost,
    };
  }
}
