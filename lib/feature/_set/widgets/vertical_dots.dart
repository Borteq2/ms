import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:mordor_suit/store/_stores.dart';

class VerticalDotsWidget extends StatelessWidget {
  const VerticalDotsWidget({
    super.key,
    required this.context,
    required this.suitStore,
    required this.currentPage,
  });

  final BuildContext context;
  final SuitStore suitStore;
  final int currentPage;

  @override
  Widget build(BuildContext context) => suitStore.layersWithItemsCount > 0
      ? DotsIndicator(
          dotsCount: suitStore.layersWithItemsCount,
          position: currentPage.toInt(),
          axis: Axis.vertical,
          decorator: DotsDecorator(
            color: Theme.of(context).disabledColor,
            activeColor: Theme.of(context).primaryColor,
          ),
        )
      : const SizedBox.shrink();
}
