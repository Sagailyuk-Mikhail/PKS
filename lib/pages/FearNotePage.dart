import 'package:flutter/material.dart';
import '../models/Note.dart';

class FearRoomPage extends StatelessWidget {
  final FearRoom fearRoom;

  const FearRoomPage({super.key, required this.fearRoom});

  // Метод для получения цвета фона в зависимости от типа страха
  Color getBackgroundColor() {
    switch (fearRoom.type) {
      case 'Фобия':
        return const Color.fromARGB(255, 255, 69, 0).withOpacity(0.75); // Оранжевый
      case 'Тревога':
        return const Color.fromARGB(255, 255, 215, 0).withOpacity(0.75); // Желтый
      case 'Паника':
        return const Color.fromARGB(255, 255, 0, 0).withOpacity(0.75); // Красный
      default:
        return Colors.black.withOpacity(0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fearRoom.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack для наложения фона, изображения и затемнения
              Stack(
                alignment: Alignment.center,
                children: [
                  // Контейнер с закругленным фоном в зависимости от типа страха
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: getBackgroundColor(), // Цвет фона в зависимости от типа
                      borderRadius: BorderRadius.circular(16.0), // Закругленные углы
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0), // Закругление изображения
                      child: Image.network(
                        fearRoom.imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.contain, // Изображение не будет растягиваться
                      ),
                    ),
                  ),
                  // Полупрозрачный контейнер для затемнения
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5), // Затемнение всего контейнера
                      borderRadius: BorderRadius.circular(16.0), // Закругленные углы
                    ),
                  ),
                  // Текст поверх затемненного изображения
                  Text(
                    fearRoom.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                fearRoom.description,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                "Интенсивность: ${fearRoom.intensity}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                "Триггер: ${fearRoom.trigger}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                "Симптомы: ${fearRoom.symptoms}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
