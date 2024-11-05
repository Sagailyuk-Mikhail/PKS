import 'package:flutter/material.dart';
import '../components/item.dart';
import '../models/Note.dart';
import '../pages/FearNotePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<FearRoom> fearRooms = [
    FearRoom(
        "Арахнофобия",
        "Испытайте свои силы в комнате, полной пауков. Ваша задача — найти выход, преодолевая страх перед этими существами.",
        "https://avatars.mds.yandex.net/get-entity_search/114969/993382517/SUx182_2x"),
    FearRoom(
        "Клаустрофобия",
        "Попробуйте выбраться из замкнутого пространства, преодолевая страх перед теснотой и нехваткой воздуха.",
        "https://s0.rbk.ru/v6_top_pics/media/img/6/05/756482987819056.jpg"),
    FearRoom(
        "Агорафобия",
        "Проверьте свои нервы в открытом пространстве, где вам нужно найти выход, преодолевая страх перед пустотой.",
        "https://avatars.mds.yandex.net/i?id=4807b2e09684e5d827bfd695cd21b593890cd00cd71693f4-12995656-images-thumbs&n=13"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("Квест комнаты")
        ),
      ),
      body: ListView.builder(
        itemCount: fearRooms.length,
        itemBuilder: (context, index) {
          final room = fearRooms[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FearRoomPage(fearRoom: room),
              ),
            ),
            child: FearRoomWidget(
              fearRoom: room,
            ),
          );
        },
      ),
    );
  }
}
