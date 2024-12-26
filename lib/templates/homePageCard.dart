import 'package:flutter/material.dart';
import '../models/FearRoom.dart';
import '../main.dart';
import '../models/AnalysisItem.dart';
import '../models/BasketItem.dart';
import '../api.dart';

class HomePageCard extends StatefulWidget {
  final FearRoom item;

  const HomePageCard({super.key, required this.item});

  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  var isAdded = false;
  var isFavorite = false;

  @override
  void initState() {
    super.initState();
    isAdded = cart.any((cartItem) => cartItem.item.id == widget.item.id);
    isFavorite = widget.item.isFavorite;
  }

  void _toggleFavorite() async {
    if (isFavorite) {
      await ApiService().removeFromFavorites(widget.item.id!);
    } else {
      await ApiService().addToFavorites(widget.item.id!);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.81,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.item.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.item.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Text(
            widget.item.description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF939396),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.item.cost.toString()}₽',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (!isAdded) {
                          isAdded = true;
                          cart.add(BasketItem(widget.item as AnalysisItem));
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: isAdded
                          ? Colors.white12
                          : const Color(0xFF1A6FEE),
                      minimumSize: const Size(96, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isAdded
                        ? const Icon(Icons.done, color: Colors.black,)
                        : const Text(
                      'Добавить',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
