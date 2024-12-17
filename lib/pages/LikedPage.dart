import 'package:flutter/material.dart';
import '../components/item.dart';
import '../models/Note.dart';
import '../pages/FearNotePage.dart';

class LikedPage extends StatefulWidget {
  final Set<FearRoom> likedGames;
  final Function(FearRoom) onLikedToggle;

  const LikedPage({
    Key? key,
    required this.likedGames,
    required this.onLikedToggle,
  }) : super(key: key);

  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  void _deleteFearRoom(FearRoom fearRoom) {
    setState(() {
      widget.likedGames.remove(fearRoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    final likedGamesList = widget.likedGames.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: likedGamesList.isEmpty
          ? const Center(child: Text('Пока что тут пусто, добавьте что-нибудь в избранное!'))
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.6,
        ),
        itemCount: likedGamesList.length,
        itemBuilder: (context, index) {
          final fearRoom = likedGamesList[index];
          return FearRoomWidget(
            fearRoom: fearRoom,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FearRoomDetailPage(
                    fearRoom: fearRoom,
                    onDelete: () {
                      _deleteFearRoom(fearRoom);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            onFavoriteToggle: () {
              widget.onLikedToggle(fearRoom);
            },
            onDelete: () {
              _deleteFearRoom(fearRoom);
            },
          );
        },
      ),
    );
  }
}
