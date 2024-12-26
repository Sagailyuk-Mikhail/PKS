import 'package:flutter/material.dart';
import '../api.dart';
import '../models/CartHistoryItem.dart';

class CartHistoryPage extends StatefulWidget {
  const CartHistoryPage({super.key});

  @override
  State<CartHistoryPage> createState() => _CartHistoryPageState();
}

class _CartHistoryPageState extends State<CartHistoryPage> {
  late Future<List<CartHistoryItem>> _cartHistoryFuture;

  @override
  void initState() {
    super.initState();
    _loadCartHistory();
  }

  void _loadCartHistory() {
    setState(() {
      _cartHistoryFuture = ApiService().getCartHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История заказов'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<CartHistoryItem>>(
              future: _cartHistoryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Ошибка загрузки истории заказов"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("История заказов пуста"));
                } else {
                  List<CartHistoryItem> history = snapshot.data!;
                  return ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.81,
                          height: 136,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFE0E0E0),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Заказ ID: ${history[index].cartId}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Количество анализов: ${history[index].countAnalyze}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF939396),
                                          ),
                                        ),
                                        Text(
                                          'Общая стоимость: ${history[index].totalCost}₽',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
