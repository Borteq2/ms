import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mordor_suit/store/_stores.dart';

// Widget generateVerticalDotsWidget(
//   BuildContext context, {
//   required AppStore appStore,
//   required int currentPage,
// }) =>
//     appStore.suitStore.layersWithItemsCount > 0
//         ? DotsIndicator(
//             dotsCount: appStore.suitStore.layersWithItemsCount,
//             position: currentPage.toInt(),
//             axis: Axis.vertical,
//             decorator: DotsDecorator(
//               color: Theme.of(context).disabledColor,
//               activeColor: Theme.of(context).primaryColor,
//             ),
//           )
//         : const SizedBox.shrink();

class VerticalDotsWidget extends StatelessWidget {
  const VerticalDotsWidget({
    super.key,
    required this.context,
    required this.appStore,
    required this.currentPage,
  });

  final BuildContext context;
  final AppStore appStore;
  final int currentPage;

  @override
  Widget build(BuildContext context)  =>
      appStore.suitStore.layersWithItemsCount > 0
          ? DotsIndicator(
        dotsCount: appStore.suitStore.layersWithItemsCount,
        position: currentPage.toInt(),
        axis: Axis.vertical,
        decorator: DotsDecorator(
          color: Theme.of(context).disabledColor,
          activeColor: Theme.of(context).primaryColor,
        ),
      )
          : const SizedBox.shrink();
}
