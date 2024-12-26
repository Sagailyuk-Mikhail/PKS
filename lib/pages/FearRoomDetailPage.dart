import 'package:flutter/material.dart';
import '../models/FearRoom.dart';
import '../api.dart';

class FearRoomDetailPage extends StatefulWidget {
  final FearRoom fearRoom;
  final VoidCallback onDelete;
  final VoidCallback onAddToCart;

  const FearRoomDetailPage({
    Key? key,
    required this.fearRoom,
    required this.onDelete,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  State<FearRoomDetailPage> createState() => _FearRoomDetailPageState();
}

class _FearRoomDetailPageState extends State<FearRoomDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fearRoom.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.fearRoom.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.fearRoom.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text('Полная информация:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.fearRoom.fullInfo,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Стоимость: ${widget.fearRoom.cost}₽',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: widget.onAddToCart,
              child: const Text('Добавить в корзину'),
            ),
          ],
        ),
      ),
    );
  }
}
