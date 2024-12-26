import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Импортируем Firebase Auth
import 'auth/auth_service.dart';
import 'models/BasketItem.dart';
import 'models/FearRoom.dart'; // Импортируем модель FearRoom
import 'firebase_options.dart';
import 'pages/RegisterPage.dart';
import 'pages/LoginPage.dart';
import 'pages/HomePage.dart';
import 'pages/CartPage.dart';
import 'pages/LikedPage.dart';
import 'pages/ProfilePage.dart';

List<BasketItem> cart = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const AuthGate(), // Используем AuthGate для проверки аутентификации
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const MyHome(); // Пользователь аутентифицирован
          } else {
            return const LoginPage(); // Пользователь не аутентифицирован
          }
        }
        // Показать индикатор загрузки, если состояние еще не активно
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;
  late Set<FearRoom> likedGames;
  late Set<FearRoom> cartItems;

  @override
  void initState() {
    super.initState();
    likedGames = {};
    cartItems = {};
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(
      likedGames: {},
      cartItems: {},
      onLikedToggle: (item) {},
      onAddToCart: (item) {},
    ),
    LikedPage(),
    CartPage(
      cartItems: {},
      onRemoveFromCart: (item) {},
      onDeleteFromCart: (item) {},
    ),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
        unselectedItemColor: Colors.grey,
        selectedItemColor: const Color(0xFF1A6FEE), // Цвет для выбранного элемента
        onTap: _onItemTapped,
      ),
    );
  }
}
