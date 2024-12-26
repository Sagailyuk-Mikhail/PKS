import 'package:flutter/material.dart';
import '../api.dart';
import '../models/FearRoom.dart';
import '../templates/favoritePageCard.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  late Future<List<FearRoom>> _favoritesFuture;
  List<String> _selectedFilters = ['все'];

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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Фильтр'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildFilterItem('все', setState),
                    _buildFilterItem('Эскейп-румы', setState),
                    _buildFilterItem('Квесты в реальности', setState),
                    _buildFilterItem('Перформансы', setState),
                    _buildFilterItem('Интерактивные квесты', setState),
                    _buildFilterItem('Приключенческие квесты', setState),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _loadFavorites();
                    });
                  },
                  child: const Text('Применить'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFilterItem(String filter, StateSetter setState) {
    return ListTile(
      title: Text(filter),
      leading: Icon(
        _selectedFilters.contains(filter) ? Icons.check_box : Icons.check_box_outline_blank,
      ),
      onTap: () => _toggleFilter(filter, setState),
    );
  }

  void _toggleFilter(String filter, StateSetter setState) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 24, left: 16),
                          child: Text(
                            "Избранные",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _showFilterDialog,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 24, right: 16),
                            child: Text(
                              "Фильтр",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<List<FearRoom>>(
                      future: _favoritesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          if (snapshot.error.toString().contains('404')) {
                            return const Center(
                              child: Text(
                                "Запланированных услуг нет",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
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
                            return _selectedFilters.contains('все') || _selectedFilters.contains(favorite.type);
                          }).toList();

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredFavorites.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: index == filteredFavorites.length - 1 ? 32 : 16),
                                child: FavoritePageCard(
                                  item: filteredFavorites[index],
                                  onFavoriteChanged: _loadFavorites,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
