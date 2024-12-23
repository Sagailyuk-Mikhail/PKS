import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../components/cart_card.dart';
import '../main.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeItem(CartItem item) {
    setState(() {
      cart.removeWhere((cartItem) => cartItem.item.name == item.item.name);
      services.firstWhere((dataItem) => dataItem.name == item.item.name).isAdd = false;
    });
  }

  int calculateTotal() {
    return cart.fold(0, (sum, item) => sum + (item.item.price * item.count));
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
                padding: EdgeInsets.only(left: 27, bottom: 38),
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
                        padding: EdgeInsets.only(
                            bottom: index == cart.length - 1 ? 0 : 16),
                        child: Column(
                          children: [
                            CartPageCard(
                                item: cart[index],
                                onRemove: removeItem,
                                onQuantityChanged: () {
                                  setState(() {});
                                }),
                            if (index == cart.length - 1)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, bottom: 100),
                                child: SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.81,
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
                                        '${calculateTotal()}₽',
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
                onPressed: () {},
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
