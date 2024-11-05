import 'package:flutter/material.dart';
import '../models/Note.dart';

class FearRoomWidget extends StatelessWidget {
  final FearRoom fearRoom;

  const FearRoomWidget({
    super.key,
    required this.fearRoom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.black, width: 2),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Квест комната: ${fearRoom.title}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Image.network(
                    fearRoom.imageUrl,
                    height: MediaQuery.of(context).size.height * 0.28, // 70% от высоты карточки
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
