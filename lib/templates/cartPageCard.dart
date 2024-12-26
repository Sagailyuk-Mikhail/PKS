import 'package:flutter/material.dart';
import '../models/BasketItem.dart';

class CartPageCard extends StatefulWidget {
  final BasketItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onCountChange;

  const CartPageCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onCountChange,
  });

  @override
  State<CartPageCard> createState() => _CartPageCardState();
}

class _CartPageCardState extends State<CartPageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.81,
      height: 136,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.item.item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.item.description,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF939396)
                      ),
                    ),
                    Text(
                      '${widget.item.item.cost.toString()}₽',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (widget.item.count > 1) {
                          setState(() {
                            widget.item.count--;
                          });
                          widget.onCountChange(widget.item.count);
                        }
                      },
                    ),
                    Text(
                      '${widget.item.count}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          widget.item.count++;
                        });
                        widget.onCountChange(widget.item.count);
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
