import 'package:flutter/material.dart';
import '../components/item.dart';
import '../models/Note.dart';
import '../pages/FearNotePage.dart';
import '../pages/AddFearRoomPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<FearRoom> fearRooms = [
    FearRoom(
      title: 'Арахнофобия',
      description: 'Испытайте свои силы в комнате, полной пауков. Ваша задача — найти выход, преодолевая страх перед этими существами.',
      imageUrl: 'https://avatars.mds.yandex.net/get-entity_search/114969/993382517/SUx182_2x',
      fullInfo: 'Испытайте свои силы в комнате, полной пауков. Ваша задача — найти выход, преодолевая страх перед этими существами.',
      type: 'Эскейп-румы',
    ),
    FearRoom(
      title: 'Клаустрофобия',
      description: 'Попробуйте выбраться из замкнутого пространства, преодолевая страх перед теснотой и нехваткой воздуха.',
      imageUrl: 'https://s0.rbk.ru/v6_top_pics/media/img/6/05/756482987819056.jpg',
      fullInfo: 'Попробуйте выбраться из замкнутого пространства, преодолевая страх перед теснотой и нехваткой воздуха.',
      type: 'Квесты в реальности',
    ),
    FearRoom(
      title: 'Агорафобия',
      description: 'Проверьте свои нервы в открытом пространстве, где вам нужно найти выход, преодолевая страх перед пустотой.',
      imageUrl: 'https://avatars.mds.yandex.net/i?id=4807b2e09684e5d827bfd695cd21b593890cd00cd71693f4-12995656-images-thumbs&n=13',
      fullInfo: 'Проверьте свои нервы в открытом пространстве, где вам нужно найти выход, преодолевая страх перед пустотой.',
      type: 'Перформансы',
    ),
  ];

  void _addFearRoom(FearRoom fearRoom) {
    setState(() {
      fearRooms.add(fearRoom);
    });
  }

  void _deleteFearRoom(int index) {
    setState(() {
      fearRooms.removeAt(index);
    });
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить эту позицию?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Нет'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Да'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Квест комнаты'),
      ),
      body: fearRooms.isEmpty
          ? const Center(child: Text('Пока что тут пусто, добавьте что-нибудь!'))
          : ListView.builder(
        itemCount: fearRooms.length,
        itemBuilder: (context, index) {
          final fearRoom = fearRooms[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0), // Увеличиваем отступы между карточками
            child: FearRoomWidget(
              fearRoom: fearRoom,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FearRoomDetailPage(fearRoom: fearRoom),
                  ),
                );
              },
              onDelete: () async {
                bool confirm = await _confirmDelete(context);
                if (confirm) {
                  _deleteFearRoom(index);
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFearRoomPage(onFearRoomAdded: _addFearRoom),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
