import 'package:flutter/material.dart';
import '../models/Note.dart';

class FearRoomDetailPage extends StatelessWidget {
  final FearRoom fearRoom;
  final VoidCallback onDelete;

  const FearRoomDetailPage({super.key, required this.fearRoom, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fearRoom.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              fearRoom.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fearRoom.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    fearRoom.fullInfo,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Тип: ${fearRoom.type}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
