import 'package:flutter/material.dart';
import 'pages/HomePage.dart';
import 'pages/LikedPage.dart';
import 'pages/ProfilePage.dart';
import 'pages/CartPage.dart';
import 'models/Note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
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
  final Set<FearRoom> cartItems = {};

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

  void _addToCart(FearRoom fearRoom) {
    setState(() {
      if (cartItems.contains(fearRoom)) {
        fearRoom.amount++;
      } else {
        fearRoom.amount = 1;
        cartItems.add(fearRoom);
      }
    });
  }

  void _removeFromCart(FearRoom fearRoom) {
    setState(() {
      if (fearRoom.amount > 1) {
        fearRoom.amount--;
      } else {
        cartItems.remove(fearRoom);
      }
    });
  }

  void _deleteFromCart(FearRoom fearRoom) {
    setState(() {
      fearRoom.amount = 0;
      cartItems.remove(fearRoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(
        likedGames: likedGames,
        cartItems: cartItems,
        onLikedToggle: _toggleFavorite,
        onAddToCart: _addToCart,
      ),
      LikedPage(
        likedGames: likedGames,
        onLikedToggle: _toggleFavorite,
        onAddToCart: _addToCart,
      ),
      CartPage(
        cartItems: cartItems,
        onRemoveFromCart: _removeFromCart,
        onDeleteFromCart: _deleteFromCart,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Изменено на fixed
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
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff504bff),
        unselectedItemColor: Colors.grey, // Добавлено для улучшения видимости
        onTap: _onItemTapped,
      ),
    );
  }
}
