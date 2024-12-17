import 'package:flutter/material.dart';
import 'pages/HomePage.dart';
import 'pages/LikedPage.dart';
import 'pages/ProfilePage.dart';
import 'models/Note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage(),);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final Set<FearRoom> likedGames = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(FearRoom fearRoom) {
    setState(() {
      if (likedGames.contains(fearRoom)) {
        likedGames.remove(fearRoom);
      } else {
        likedGames.add(fearRoom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(
        likedGames: likedGames,
        onLikedToggle: _toggleFavorite,
      ),
      LikedPage(
        likedGames: likedGames,
        onLikedToggle: _toggleFavorite,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff504bff), // Customize as needed
        onTap: _onItemTapped,
      ),
    );
  }
}
