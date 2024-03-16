import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:mordor_suit/store/_stores.dart';

class HorizontalDotsWidget extends StatelessWidget {
  const HorizontalDotsWidget({
    super.key,
    required this.context,
    required this.suitStore,
    required this.currentPage2,
    required this.index,
  });

  final BuildContext context;
  final SuitStore suitStore;
  final int currentPage2;
  final int index;

  @override
  Widget build(BuildContext context) =>
      suitStore.resultMap.entries.elementAt(index).value.isNotEmpty
          ? DotsIndicator(
              dotsCount:
                  suitStore.resultMap.entries.elementAt(index).value.length,
              position: currentPage2.toInt(),
              axis: Axis.horizontal,
              decorator: DotsDecorator(
                color: Theme.of(context).disabledColor,
                activeColor: Theme.of(context).primaryColor,
              ),
            )
          : const SizedBox.shrink();
}
