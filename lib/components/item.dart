import 'package:flutter/material.dart';
import '../models/Note.dart';

class FearRoomWidget extends StatelessWidget {
  final FearRoom fearRoom;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onDelete;

  const FearRoomWidget({
    super.key,
    required this.fearRoom,
    required this.onTap,
    required this.onFavoriteToggle,
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
        return Icons.warning;
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
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: Image.network(
                    fearRoom.imageUrl,
                    height: 150, // Увеличена высота изображения
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      fearRoom.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: fearRoom.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onFavoriteToggle,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fearRoom.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        fearRoom.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(getIconForType(fearRoom.type)),
                          const SizedBox(width: 4),
                          Expanded( // Используем Expanded для предотвращения переполнения
                            child: Text(
                              fearRoom.type,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
