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
  String searchQuery = "";
  String selectedType = "";

  final List<FearRoom> fearRooms = [
    FearRoom(
        "Арахнофобия",
        "Фобия",
        "Страх перед пауками",
        "https://avatars.mds.yandex.net/get-entity_search/114969/993382517/S600xU_2x",
        8,
        "Пауки",
        "Тремор, потливость, учащенное сердцебиение"),
    FearRoom(
        "Клаустрофобия",
        "Фобия",
        "Страх перед замкнутыми пространствами",
        "https://s0.rbk.ru/v6_top_pics/media/img/6/05/756482987819056.jpg",
        7,
        "Замкнутые пространства",
        "Паника, одышка, головокружение"),
    FearRoom(
        "Агорафобия",
        "Тревога",
        "Страх перед открытыми пространствами",
        "https://avatars.mds.yandex.net/i?id=4807b2e09684e5d827bfd695cd21b593890cd00cd71693f4-12995656-images-thumbs&n=13",
        6,
        "Открытые пространства",
        "Тревога, паника, потливость"),
  ];

  List<FearRoom> filteredFearRooms() {
    return fearRooms
        .where((room) =>
    room.title.toLowerCase().contains(searchQuery.toLowerCase()) &&
        room.type.toLowerCase().contains(selectedType.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        title: Text("Квест комнаты"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => setState(() => searchQuery = query),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilterChip(
                label: const Text("Фобия"),
                selected: selectedType == "Фобия",
                onSelected: (selected) =>
                    setState(() => selectedType = selected ? "Фобия" : ""),
              ),
              FilterChip(
                label: const Text("Тревога"),
                selected: selectedType == "Тревога",
                onSelected: (selected) =>
                    setState(() => selectedType = selected ? "Тревога" : ""),
              ),
              FilterChip(
                label: const Text("Паника"),
                selected: selectedType == "Паника",
                onSelected: (selected) =>
                    setState(() => selectedType = selected ? "Паника" : ""),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFearRooms().length,
              itemBuilder: (context, index) {
                final room = filteredFearRooms()[index];
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
          ),
        ],
      ),
    );
  }
}
