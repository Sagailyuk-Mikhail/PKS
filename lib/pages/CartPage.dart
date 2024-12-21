import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/Note.dart';

class CartPage extends StatefulWidget {
  final Set<FearRoom> cartItems;
  final Function(FearRoom) onRemoveFromCart;
  final Function(FearRoom) onDeleteFromCart;

  const CartPage({
    Key? key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onDeleteFromCart,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _incrementQuantity(FearRoom fearRoom) {
    setState(() {
      fearRoom.amount++;
    });
  }

  void _decrementQuantity(FearRoom fearRoom) {
    setState(() {
      if (fearRoom.amount > 1) {
        fearRoom.amount--;
      }
    });
  }

  int _calculateTotal() {
    return widget.cartItems.fold(0, (sum, item) => sum + (item.cost * item.amount));
  }

  void _showDeleteToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _confirmDelete(FearRoom fearRoom) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: Text('Вы уверены, что хотите удалить "${fearRoom.title}" из корзины?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог
              },
            ),
            TextButton(
              child: const Text('Удалить'),
              onPressed: () {
                widget.onDeleteFromCart(fearRoom); // Удалить товар
                _showDeleteToast('Товар "${fearRoom.title}" удален из корзины');
                Navigator.of(context).pop(); // Закрыть диалог
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItemsList = widget.cartItems.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: cartItemsList.isEmpty
          ? const Center(child: Text('Ваша корзина пуста!'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItemsList.length,
              itemBuilder: (context, index) {
                final fearRoom = cartItemsList[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          // Показать диалог подтверждения удаления
                          _confirmDelete(fearRoom);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Удалить',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Image.network(
                      fearRoom.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(fearRoom.title),
                    subtitle: Text('${fearRoom.cost} руб.'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _decrementQuantity(fearRoom),
                        ),
                        Text('${fearRoom.amount}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _incrementQuantity(fearRoom),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Общая сумма:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_calculateTotal()} руб.',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
