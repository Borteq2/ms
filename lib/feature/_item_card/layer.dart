import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ItemCardLayerWidget extends StatelessWidget {
  const ItemCardLayerWidget({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return item.inSuitLayer != null
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: AutoSizeText(
              '${item.inSuitLayer}',
              style: const TextStyle(fontSize: 20),
              maxLines: 1,
            ),
          )
        : const SizedBox.shrink();
  }
}
