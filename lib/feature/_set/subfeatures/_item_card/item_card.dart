import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:mordor_suit/feature/_set/subfeatures/_item_card/_widgets.dart';
import 'package:mordor_suit/library/config/sizes.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:mordor_suit/store/_stores.dart';

enum CardType { vertical, horizontal }

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.appStore,
    required this.currentItem,
    required this.index,
    required this.onHaveAlreadyBtnTap,
  });

  final AppStore appStore;
  final Clothing currentItem;
  final int index;
  final VoidCallback onHaveAlreadyBtnTap;

  SuitStore get suitStore => appStore.suitStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: GetIt.I<SizesConfig>().isKeyboardOpen ? 1 : 0,
                  child: ItemCardImageWidget(item: currentItem)),
              ItemCardNameWidget(item: currentItem),
              ItemCardLinkWidget(
                appStore: appStore,
                item: currentItem,
                onHaveAlreadyBtnTap: onHaveAlreadyBtnTap,
              ),
              ItemCardFeaturesListWidget(item: currentItem),
              ItemCardLayerWidget(item: currentItem),
              ItemCardNecessaryWidget(item: currentItem, index: index),
            ],
          ),
        ),
      ),
    );
  }
}




