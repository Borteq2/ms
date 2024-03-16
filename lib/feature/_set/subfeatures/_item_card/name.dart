import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ItemCardNameWidget extends StatelessWidget {
  const ItemCardNameWidget({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: AutoSizeText(
        '${item.name}',
        style: const TextStyle(fontSize: 18),
        maxLines: 1,
      ),
    );
  }
}
