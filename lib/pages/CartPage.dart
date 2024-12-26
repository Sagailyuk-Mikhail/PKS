import 'package:flutter/material.dart';
import '../main.dart';
import '../templates/cartPageCard.dart';
import '../api.dart';
import '../models/BasketItem.dart';
import '../models/FearRoom.dart';

class CartPage extends StatefulWidget {
  final Set<FearRoom> cartItems;
  final Function(FearRoom) onRemoveFromCart;
  final Function(FearRoom) onDeleteFromCart;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onDeleteFromCart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeItem(BasketItem item) {
    setState(() {
      cart.remove(item);
    });
  }

  void updateItemCount(BasketItem item, int newCount) {
    setState(() {
      item.count = newCount;
    });
  }

  void clearCart() {
    setState(() {
      cart.clear();
    });
  }

  void _postToUserCart() async {
    try {
      await ApiService().postToUserCart(cart);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ваш заказ успешно оформлен!'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Закрыть',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      clearCart();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка отправки корзины: $e'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Закрыть',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 92, left: 27),
                child: Text(
                  "Корзина",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: cart.isEmpty
                    ? const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Корзина пуста",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: index == cart.length - 1 ? 0 : 16),
                        child: Column(
                          children: [
                            CartPageCard(
                              item: cart[index],
                              onRemove: () => removeItem(cart[index]),
                              onCountChange: (newCount) => updateItemCount(cart[index], newCount),
                            ),
                            if (index == cart.length - 1)
                              Padding(
                                padding: const EdgeInsets.only(top: 30, bottom: 100),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.81,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Сумма",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${cart.map((item) => item.item.cost * item.count).reduce((value, element) => value + element)}₽',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          cart.isEmpty
              ? const SizedBox()
              : Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _postToUserCart,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF1A6FEE),
                  minimumSize: const Size(335, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Перейти к оформлению заказа',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
