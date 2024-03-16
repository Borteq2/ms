import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ItemCardFeaturesListWidget extends StatelessWidget {
  const ItemCardFeaturesListWidget({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item.features.length,
          itemBuilder: (context, featureIndex) => featureIndex + 1 ==
                  item.features.length
              ? Column(
                  children: [
                    const Divider(thickness: 1),
                    AutoSizeText('${item.features[featureIndex]}', maxLines: 2),
                  ],
                )
              : AutoSizeText('● ${item.features[featureIndex]}', maxLines: 2),
        ),
      ),
    );
  }
}
