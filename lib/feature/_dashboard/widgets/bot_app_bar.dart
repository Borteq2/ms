import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
            // IconButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => TalkerScreen(talker: GetIt.I<Talker>()),
            //         )
            //     );
            //   },
            //   tooltip: '',
            //   icon: const Icon(Icons.arrow_upward, size: 28),
            // ),
            // IconButton(
            //   onPressed: () {
            //     appStore.clothingMemoryStore.setClothingToBox(appStore.suitStore.suit.layer_1![0]);
            //   },
            //   tooltip: '',
            //   icon: const Icon(Icons.arrow_downward, size: 28),
            // ),
            // if (appStore.centerLocations.contains(appStore.fabLocation))
            //   const Spacer(),
            // IconButton(
            //   onPressed: () async {
            //     appStore.clothingMemoryStore.dropUnboxedLists();
            //     await appStore.clothingMemoryStore.dropBoxes();
            //   },
            //   tooltip: '',
            //   icon: const Icon(Icons.clear, size: 28),
            // ),
            // IconButton(
            //   onPressed: () {
            //     appStore.clothingMemoryStore.syncHasAlreadyListsWithBoxes();
            //   },
            //   tooltip: '',
            //   icon: const Icon(Icons.sync, size: 28),
            // ),
          ],
        ),
      ),
    );
  }
}