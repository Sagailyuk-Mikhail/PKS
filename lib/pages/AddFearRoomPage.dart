import 'package:flutter/material.dart';
import '../api.dart';
import '../models/FearRoom.dart';

class AddFearRoomPage extends StatefulWidget {
  final Function(FearRoom) onFearRoomAdded;

  const AddFearRoomPage({super.key, required this.onFearRoomAdded});

  @override
  State<AddFearRoomPage> createState() => _AddFearRoomPageState();
}

class _AddFearRoomPageState extends State<AddFearRoomPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _fullInfoController = TextEditingController();
  final _costController = TextEditingController();
  String _selectedType = 'Эскейп-румы';

  void _addFearRoom() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final imageUrl = _imageUrlController.text;
    final fullInfo = _fullInfoController.text;
    final cost = int.tryParse(_costController.text) ?? 0;

    if (title.isNotEmpty && description.isNotEmpty && imageUrl.isNotEmpty && fullInfo.isNotEmpty && cost > 0) {
      final newItem = FearRoom(
        title: title,
        description: description,
        imageUrl: imageUrl,
        fullInfo: fullInfo,
        cost: cost,
        type: _selectedType,
        isFavorite: false,
      );

      try {
        await ApiService().addFearRoom(newItem);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Элемент успешно добавлен!'),
            duration: Duration(seconds: 3),
          ),
        );
        _titleController.clear();
        _descriptionController.clear();
        _imageUrlController.clear();
        _fullInfoController.clear();
        _costController.clear();
        Navigator.of(context).pop(newItem);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка добавления элемента: $e'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить комнату страха'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            ElevatedButton(
              onPressed: _addFearRoom,
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
