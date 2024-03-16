import 'package:flutter/material.dart';

class ItemCardImageWidget extends StatelessWidget {
  const ItemCardImageWidget({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset('${item.image}'),
    );
  }
}