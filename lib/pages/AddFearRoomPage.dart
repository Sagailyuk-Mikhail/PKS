import 'package:flutter/material.dart';
import '../models/Note.dart';

class AddFearRoomPage extends StatefulWidget {
  final Function(FearRoom) onFearRoomAdded;

  const AddFearRoomPage({super.key, required this.onFearRoomAdded});

  @override
  AddFearRoomPageState createState() => AddFearRoomPageState();
}

class AddFearRoomPageState extends State<AddFearRoomPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _fullInfoController = TextEditingController();
  final _costController = TextEditingController();
  final _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить квест комнату'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите название';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Изображение в формате URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите URL изображения';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Краткое описание'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите краткое описание';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fullInfoController,
                decoration: const InputDecoration(labelText: 'Полное описание'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите полное описание';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите цену';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Тип квест-комнаты'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите тип квест-комнаты';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newFearRoom = FearRoom(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      imageUrl: _imageUrlController.text,
                      fullInfo: _fullInfoController.text,
                      cost: int.parse(_costController.text),
                      type: _typeController.text,
                    );
                    widget.onFearRoomAdded(newFearRoom);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
