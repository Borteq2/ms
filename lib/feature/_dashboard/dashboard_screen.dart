import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mordor_suit/feature/_dashboard/widgets/_widgets.dart';
import 'package:mordor_suit/feature/library/widgets/_widgets.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

import 'package:mordor_suit/store/_stores.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Talker talker = GetIt.I<Talker>();
  AppStore appStore = GetIt.I<AppStore>();

  @override
  void initState() {
    super.initState();
    appStore.currentWeatherStore.geoPermission = true;
    appStore.currentWeatherStore.getLocationAndWeatherData();

    appStore.checkTimestamp().then((_) => setState(() {}));
    // if (appStore.isNeedLoadData) {
    appStore.weatherPresetsStore.fetchCityWeatherData();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: TitleWidget(appStore: appStore),
        ),
        body: PresetsGridWidget(appStore: appStore),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          child: FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddPresetModal(appStore: appStore),
            ),
            tooltip: 'Как экипироваться по погоде?',
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/images/favicon.svg',
              width: 60,
              height: 60,
            ),
          ),
        ),
        floatingActionButtonLocation: appStore.fabLocation,
        bottomNavigationBar: BotAppBar(appStore: appStore),
      ),
    );
  }
}

class AddPresetModal extends StatefulWidget {
  final AppStore appStore;

  const AddPresetModal({
    Key? key,
    required this.appStore,
  }) : super(key: key);

  @override
  _AddPresetModalState createState() => _AddPresetModalState();
}

class _AddPresetModalState extends State<AddPresetModal> {
  late TextEditingController _cityNameController;

  @override
  void initState() {
    super.initState();
    _cityNameController = TextEditingController();
  }

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppStore appStore = widget.appStore;

    return AlertDialog(
      title: const Text('Добавить локацию'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _cityNameController,
              decoration: const InputDecoration(labelText: 'Город'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            appStore.weatherPresetsStore.addPreset(_cityNameController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}
