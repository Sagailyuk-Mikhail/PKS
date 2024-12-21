import 'package:flutter/material.dart';
import '../models/Note.dart';
import '../pages/AddFearRoomPage.dart';
import '../pages/CartPage.dart';
import '../pages/FearNotePage.dart';
import '../components/item.dart';

class HomePage extends StatefulWidget {
  final Set<FearRoom> likedGames;
  final Set<FearRoom> cartItems;
  final Function(FearRoom) onLikedToggle;
  final Function(FearRoom) onAddToCart;

  const HomePage({
    Key? key,
    required this.likedGames,
    required this.cartItems,
    required this.onLikedToggle,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FearRoom> fearRooms = [
    FearRoom(
      title: 'Арахнофобия',
      description: 'Испытайте свои силы в комнате, полной пауков. Ваша задача — найти выход, преодолевая страх перед этими существами.',
      imageUrl: 'https://avatars.mds.yandex.net/get-shedevrum/13672789/img_4fd2299ebc0711ef91b3eac5d837a6da/orig',
      fullInfo: 'Испытайте свои силы в комнате, полной пауков. Ваша задача — найти выход, преодолевая страх перед этими существами.',
      cost: 1000,
      type: 'Эскейп-румы',
    ),
    FearRoom(
      title: 'Клаустрофобия',
      description: 'Попробуйте выбраться из замкнутого пространства, преодолевая страх перед теснотой и нехваткой воздуха.',
      imageUrl: 'https://avatars.mds.yandex.net/get-shedevrum/15296012/img_5fce4c4abc0811efad090e7f2f591fdc/orig',
      fullInfo: 'Попробуйте выбраться из замкнутого пространства, преодолевая страх перед теснотой и нехваткой воздуха.',
      cost: 1200,
      type: 'Квесты в реальности',
    ),
    FearRoom(
      title: 'Агорафобия',
      description: 'Проверьте свои нервы в открытом пространстве, где вам нужно найти выход, преодолевая страх перед пустотой.',
      imageUrl: 'https://avatars.mds.yandex.net/get-shedevrum/15247898/img_e2cfa4bebc0811ef91b3eac5d837a6da/orig',
      fullInfo: 'Проверьте свои нервы в открытом пространстве, где вам нужно найти выход, преодолевая страх перед пустотой.',
      cost: 1500,
      type: 'Перформансы',
    ),
    FearRoom(
      title: 'Безумие Алисы',
      description: 'Погрузитесь в мир загадок и иллюзий с квестом "Безумие Алисы", где границы реальности размыты.',
      imageUrl: 'https://avatars.mds.yandex.net/get-shedevrum/14794476/img_2ac6a84bbc0911ef90fb7a1fca1a5260/orig',
      fullInfo: 'Погрузитесь в мир загадок и иллюзий с квестом "Безумие Алисы", где границы реальности размыты.',
      cost: 1800,
      type: 'Интерактивные квесты',
    ),
    FearRoom(
      title: 'Пиратский клад',
      description: 'Отправьтесь в приключение по поиску пиратского клада с картой и головоломками.',
      imageUrl: 'https://avatars.mds.yandex.net/get-shedevrum/15170052/img_908e4fd5bc0911efac8602fc262e3b4d/orig',
      fullInfo: 'Отправьтесь в приключение по поиску пиратского клада с картой и головоломками.',
      cost: 2000,
      type: 'Приключенческие квесты',
    ),
  ];

  void _navigateToAddFearRoomPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFearRoomPage(onFearRoomAdded: addNewFearRoom),
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        fearRooms.add(result);
      });
    }
  }

  void addNewFearRoom(FearRoom newFearRoom) {
    setState(() {
      fearRooms.add(newFearRoom);
    });
  }

  void _deleteFearRoom(int index) {
    setState(() {
      fearRooms.removeAt(index);
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
      body: fearRooms.isEmpty
          ? const Center(child: Text('Пока что тут пусто, добавьте что-нибудь!'))
          : GridView.builder(
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
          return FearRoomWidget(
            fearRoom: fearRoom,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FearRoomDetailPage(
                    fearRoom: fearRoom,
                    onDelete: () {
                      _deleteFearRoom(index);
                      Navigator.pop(context);
                    },
                    onAddToCart: () {
                      widget.onAddToCart(fearRoom);
                    },
                  ),
                ),
              );
            },
            onFavoriteToggle: () {
              setState(() {
                fearRoom.isFavorite = !fearRoom.isFavorite;
              });
              widget.onLikedToggle(fearRoom);
            },
            onAddToCart: () {
              widget.onAddToCart(fearRoom);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFearRoomPage(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
