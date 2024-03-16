import 'package:flutter/material.dart';

class ItemCardNecessaryWidget extends StatelessWidget {
  const ItemCardNecessaryWidget({
    super.key,
    required this.index,
    required this.item,
  });

  final int index;
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        index == 0 ? 'Рекомендуется' : 'Альтернатива',
        style: TextStyle(color: index == 0 ? Colors.deepOrange : Colors.grey),
      ),
    );
  }
}
