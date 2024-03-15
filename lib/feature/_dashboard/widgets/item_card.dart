import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:mordor_suit/feature/_item_card/_widgets.dart';
import 'package:mordor_suit/feature/library/config/sizes.dart';
import 'package:mordor_suit/store/_stores.dart';

enum CardType { vertical, horizontal }

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.appStore,
    required this.index,
    required this.currentPage,
    required this.type,
    required this.onHaveAlreadyBtnTap,
  });

  final AppStore appStore;
  final int index;
  final int currentPage;
  final CardType type;
  final VoidCallback onHaveAlreadyBtnTap;

  SuitStore get suitStore => appStore.suitStore;

  dynamic get currentItem => type == CardType.vertical
      ? suitStore.resultMap.entries.elementAt(index).value[0]
      : suitStore.resultMap.entries.elementAt(currentPage).value[index];

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




