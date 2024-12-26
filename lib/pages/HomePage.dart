import 'package:flutter/material.dart';
import '../models/FearRoom.dart';
import '../pages/AddFearRoomPage.dart';
import '../pages/CartPage.dart';
import '../api.dart';
import '../pages/FearRoomDetailPage.dart';
import '../templates/homePageCard.dart'; // Импорт виджета HomePageCard

class HomePage extends StatefulWidget {
  final Set<FearRoom> likedGames;
  final Set<FearRoom> cartItems;
  final Function(FearRoom)? onLikedToggle;
  final Function(FearRoom)? onAddToCart;

  const HomePage({
    Key? key,
    required this.likedGames,
    required this.cartItems,
    this.onLikedToggle,
    this.onAddToCart,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<FearRoom>> _fearRoomsFuture;

  @override
  void initState() {
    super.initState();
    _loadFearRooms();
  }

  void _loadFearRooms() {
    setState(() {
      _fearRoomsFuture = ApiService().getFearRooms();
    });
  }

  void _navigateToAddFearRoomPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFearRoomPage(onFearRoomAdded: addNewFearRoom),
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _loadFearRooms(); // Перезагружаем список комнат страха после добавления новой
      });
    }
  }

  void addNewFearRoom(FearRoom newFearRoom) async {
    await ApiService().addFearRoom(newFearRoom);
    setState(() {
      _loadFearRooms(); // Перезагружаем список комнат страха после добавления новой
    });
  }

  void _deleteFearRoom(FearRoom fearRoom) async {
    await ApiService().deleteFearRoom(fearRoom.id!);
    setState(() {
      _loadFearRooms(); // Перезагружаем список комнат страха после удаления
    });
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          cartItems: widget.cartItems,
          onRemoveFromCart: (item) {
            setState(() {
              widget.cartItems.remove(item);
            });
          },
          onDeleteFromCart: (item) {
            setState(() {
              widget.cartItems.remove(item);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Квест комнаты'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: _navigateToCart, // Переход на страницу корзины
              ),
              if (widget.cartItems.isNotEmpty)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '${widget.cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<FearRoom>>(
        future: _fearRoomsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки данных'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Пока что тут пусто, добавьте что-нибудь!'));
          } else {
            List<FearRoom> fearRooms = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.6,
              ),
              itemCount: fearRooms.length,
              itemBuilder: (context, index) {
                final fearRoom = fearRooms[index];
                return GestureDetector(
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
                          onAddToCart: () {
                            if (widget.onAddToCart != null) {
                              widget.onAddToCart!(fearRoom);
                            }
                          },
                        ),
                      ),
                    );
                  },
                  child: HomePageCard(item: fearRoom),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFearRoomPage(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
