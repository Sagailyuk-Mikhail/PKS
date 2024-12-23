import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/cart.dart';
import 'models/service.dart';
import 'pages/home_page.dart';

List<ServiceModel> services = [
  ServiceModel(
      name: 'ПЦР-тест на определение РНК коронавируса стандартный',
      duration: '2 дня',
      price: 1800),
  ServiceModel(
      name: 'Клинический анализ крови с лейкоцитарной формулой',
      duration: '1 день',
      price: 690),
  ServiceModel(
      name: 'Биохимический анализ крови, базовый',
      duration: '1 день',
      price: 2440),
  ServiceModel(
      name: 'Анализ на витамин D',
      duration: '3 дня',
      price: 1200),
  ServiceModel(
      name: 'Анализ на холестерин',
      duration: '2 дня',
      price: 800),
  ServiceModel(
      name: 'Анализ на глюкозу',
      duration: '1 день',
      price: 500),
  ServiceModel(
      name: 'Анализ на железо',
      duration: '2 дня',
      price: 700),
];
List<CartItem> cart = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Каталог услуг',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
