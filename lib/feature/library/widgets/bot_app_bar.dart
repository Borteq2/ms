import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mordor_suit/store/_stores.dart';

class BotAppBar extends StatelessWidget {
  const BotAppBar({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BottomAppBar(
        elevation: 20,
        surfaceTintColor: Theme.of(context).bottomAppBarTheme.surfaceTintColor,
        shape: const CircularNotchedRectangle(),
        height: 64,
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (appStore.centerLocations.contains(appStore.fabLocation))
              const Spacer(),
            // IconButton(
            //   onPressed: () {},
            //   tooltip: 'Отправить баг-репорт',
            //   icon: const Icon(Icons.bug_report_outlined, size: 28),
            // ),
          ],
        ),
      ),
    );
  }
}
