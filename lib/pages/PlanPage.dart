import 'package:flutter/material.dart';
import '../api.dart';
import '../models/FearRoom.dart';
import '../templates/favoritePageCard.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  late Future<List<FearRoom>> _favoritesFuture;
  String _selectedFilter = 'все';

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      _favoritesFuture = ApiService().getFavorites();
    });
  }

  void _filterFavorites(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 92, left: 27),
                child: Text(
                  "Избранные услуги",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 92, left: 27, right: 35),
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _filterFavorites(newValue);
                    }
                  },
                  items: <String>['все', 'Эскейп-румы', 'Квесты в реальности', 'Перформансы', 'Интерактивные квесты', 'Приключенческие квесты']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<FearRoom>>(
              future: _favoritesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  if (snapshot.error.toString().contains('404')) {
                    return const Center(child: Text("Запланированных услуг нет",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )));
                  } else {
                    return const Center(child: Text("Ошибка загрузки данных"));
                  }
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Запланированных услуг нет",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  List<FearRoom> favorites = snapshot.data!;
                  List<FearRoom> filteredFavorites = favorites.where((favorite) {
                    return _selectedFilter == 'все' || favorite.type == _selectedFilter;
                  }).toList();
                  return ListView.builder(
                    itemCount: filteredFavorites.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: index == filteredFavorites.length - 1 ? 32 : 16),
                          child: FavoritePageCard(
                            item: filteredFavorites[index],
                            onFavoriteChanged: _loadFavorites,
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
