import 'service.dart';

class CartItem {
  final ServiceModel item;
  int count;

  CartItem(this.item, {this.count = 1});
}
