import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/service_card.dart';
import '../main.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import '../models/service.dart';
import '../models/cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _addToCart(ServiceModel service) {
    setState(() {
      service.isAdd = true;
      cart.add(CartItem(service));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildServiceCatalogPage(),
          const CartPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(size: 30),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'icons/home.svg',
              width: 24,
              height: 24,
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
            ),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'icons/cart.svg',
              width: 24,
              height: 24,
              color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
            ),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'icons/profile.svg',
              width: 30,
              height: 30,
              color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
            ),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCatalogPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 32, top: 20),
            child: Text(
              "Каталог услуг",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return ServiceCard(
                  service: service,
                  onAdd: () => _addToCart(service),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
