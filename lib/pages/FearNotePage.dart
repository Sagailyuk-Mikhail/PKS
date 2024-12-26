import 'package:flutter/material.dart';
import '../api.dart';
import '../models/FearRoom.dart';
import '../templates/homePageCard.dart';
import '../models/AnalysisItem.dart';

class FearNotePage extends StatefulWidget {
  const FearNotePage({super.key});

  @override
  State<FearNotePage> createState() => _FearNotePageState();
}

class _FearNotePageState extends State<FearNotePage> {
  late Future<List<FearRoom>> _fearRoomsFuture;
  String _selectedFilter = 'все';

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

  void _filterFearRooms(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _showAddItemDialog(BuildContext context, FearRoom? item) {
    final _titleController = TextEditingController(text: item?.title ?? '');
    final _descriptionController = TextEditingController(text: item?.description ?? '');
    final _imageUrlController = TextEditingController(text: item?.imageUrl ?? '');
    final _fullInfoController = TextEditingController(text: item?.fullInfo ?? '');
    final _costController = TextEditingController(text: item?.cost.toString() ?? '');
    String _selectedType = item?.type ?? 'Эскейп-румы';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Обновить или удалить комнату страха'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Название',
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Описание',
                    ),
                  ),
                  TextField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(
                      labelText: 'URL изображения',
                    ),
                  ),
                  TextField(
                    controller: _fullInfoController,
                    decoration: const InputDecoration(
                      labelText: 'Полная информация',
                    ),
                  ),
                  TextField(
                    controller: _costController,
                    decoration: const InputDecoration(
                      labelText: 'Стоимость',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  DropdownButton<String>(
                    value: _selectedType,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedType = newValue;
                        });
                      }
                    },
                    items: <String>['Эскейп-румы', 'Квесты в реальности', 'Перформансы', 'Интерактивные квесты', 'Приключенческие квесты']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () async {
                    final title = _titleController.text;
                    final description = _descriptionController.text;
                    final imageUrl = _imageUrlController.text;
                    final fullInfo = _fullInfoController.text;
                    final cost = int.tryParse(_costController.text) ?? 0;

                    if (title.isNotEmpty && description.isNotEmpty && imageUrl.isNotEmpty && fullInfo.isNotEmpty && cost > 0) {
                      final updatedItem = FearRoom(
                        id: item?.id,
                        title: title,
                        description: description,
                        imageUrl: imageUrl,
                        fullInfo: fullInfo,
                        cost: cost,
                        type: _selectedType,
                        isFavorite: item?.isFavorite ?? false,
                      );

                      try {
                        if (item != null) {
                          await ApiService().updateProduct(updatedItem as AnalysisItem);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Элемент успешно обновлен!'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else {
                          await ApiService().addFearRoom(updatedItem);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Элемент успешно добавлен!'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                        _titleController.clear();
                        _descriptionController.clear();
                        _imageUrlController.clear();
                        _fullInfoController.clear();
                        _costController.clear();
                        Navigator.of(context).pop();
                        _loadFearRooms();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ошибка обновления элемента: $e'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Пожалуйста, заполните все поля'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: const Text('Обновить или добавить'),
                ),
                TextButton(
                  onPressed: () async {
                    if (item != null) {
                      try {
                        await ApiService().deleteFearRoom(item.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Элемент успешно удален!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        Navigator.of(context).pop();
                        _loadFearRooms();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ошибка удаления элемента: $e'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Удалить'),
                ),
              ],
            );
          },
        );
      },
    );
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
                  "Каталог услуг",
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
                      _filterFearRooms(newValue);
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
              future: _fearRoomsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Ошибка загрузки данных"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Каталог пуст",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  List<FearRoom> fearRooms = snapshot.data!;
                  List<FearRoom> filteredFearRooms = fearRooms.where((room) {
                    return _selectedFilter == 'все' || room.type == _selectedFilter;
                  }).toList();
                  return ListView.builder(
                    itemCount: filteredFearRooms.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == filteredFearRooms.length) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                _showAddItemDialog(context, null);
                              },
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: index == filteredFearRooms.length - 1 ? 15 : 16),
                            child: GestureDetector(
                              onTap: () {
                                _showAddItemDialog(context, filteredFearRooms[index]);
                              },
                              child: HomePageCard(item: filteredFearRooms[index]),
                            ),
                          ),
                        );
                      }
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
