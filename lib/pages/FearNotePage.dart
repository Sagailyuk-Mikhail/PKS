import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/Note.dart';

class FearRoomDetailPage extends StatelessWidget {
  final FearRoom fearRoom;

  const FearRoomDetailPage({super.key, required this.fearRoom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fearRoom.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: fearRoom.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fearRoom.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    fearRoom.fullInfo,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Тип: ${fearRoom.type}',
                    style: Theme.of(context).textTheme.bodyMedium,
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
