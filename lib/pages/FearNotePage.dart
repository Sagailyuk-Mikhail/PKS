import 'package:flutter/material.dart';
import '../models/Note.dart';

class FearRoomPage extends StatelessWidget {
  final FearRoom fearRoom;

  const FearRoomPage({super.key, required this.fearRoom});

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
              Center(
                child: Text(
                  fearRoom.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Image.network(fearRoom.imageUrl),
              const SizedBox(height: 16),
              Text(
                fearRoom.description,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
