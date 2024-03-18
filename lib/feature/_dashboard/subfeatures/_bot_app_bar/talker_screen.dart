import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenWidget extends StatelessWidget {
  const TalkerScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              TalkerScreen(talker: GetIt.I<Talker>()),
        ));
      },
      tooltip: '',
      icon: const Icon(Icons.perm_device_info, size: 28),
    );
  }
}