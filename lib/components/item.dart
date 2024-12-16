import 'package:flutter/material.dart';
import '../models/Note.dart';

class FearRoomWidget extends StatelessWidget {
  final FearRoom fearRoom;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const FearRoomWidget({
    super.key,
    required this.fearRoom,
    required this.onTap,
    required this.onDelete,
  });

  IconData getIconForType(String type) {
    switch (type) {
      case 'Эскейп-румы':
        return Icons.lock;
      case 'Квесты в реальности':
        return Icons.explore;
      case 'Перформансы':
        return Icons.theater_comedy;
      case 'Экшн-квесты':
        return Icons.directions_run;
      case 'Морфеус':
        return Icons.visibility_off;
      case 'Хоррор-квесты':
        return Icons.warning; // Заменим на другую иконку
      case 'Виртуальные квесты':
        return Icons.videogame_asset;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0, // Добавляем тень
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Закругленные углы
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.network(
                fearRoom.imageUrl,
                fit: BoxFit.cover,
                height: 200, // Высота изображения
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fearRoom.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fearRoom.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(getIconForType(fearRoom.type)),
                      const SizedBox(width: 4),
                      Text(
                        fearRoom.type,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
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
