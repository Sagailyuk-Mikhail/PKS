import 'package:flutter/material.dart';
import '../models/Note.dart';

class FearRoomWidget extends StatelessWidget {
  final FearRoom fearRoom;

  const FearRoomWidget({
    super.key,
    required this.fearRoom,
  });

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: getBackgroundColor(),
          border: Border.all(color: Colors.white, width: 2),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  fearRoom.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                fearRoom.type,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Image.network(fearRoom.imageUrl, height: 100),
              const SizedBox(height: 10),
              Text(
                "Интенсивность: ${fearRoom.intensity}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Триггер: ${fearRoom.trigger}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Симптомы: ${fearRoom.symptoms}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
