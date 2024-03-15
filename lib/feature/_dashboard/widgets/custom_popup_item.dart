import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import 'package:mordor_suit/feature/library/logic/report.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/store/local_weather_store.dart';

class CustomPopupMenuItem extends StatefulWidget {
  const CustomPopupMenuItem({
    Key? key,
    required this.appStore,
  }) : super(key: key);

  final AppStore appStore;

  @override
  _CustomPopupMenuItemState createState() => _CustomPopupMenuItemState();
}

class _CustomPopupMenuItemState extends State<CustomPopupMenuItem> {
  LocalWeatherStore get localWeatherStore => widget.appStore.localWeatherStore;

  SuitStore get suitStore => widget.appStore.suitStore;

  CurrentWeatherStore get currentWeatherStore =>
      widget.appStore.currentWeatherStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListTile(
        trailing: localWeatherStore.isWeatherLoaded
            ? const SizedBox.shrink()
            : const SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
        enabled: localWeatherStore.isWeatherLoaded,
        onTap: () {
          Report.map(
            index: null,
            event: 'Нажата кнопка "Одеться здесь и сейчас',
            map: {
              'Локальная погода':
                  '${localWeatherStore.temperature}, ${localWeatherStore.weather}'
            },
          );

          currentWeatherStore
              .setSuitByWeatherManually(localWeatherStore.localWeatherDataMap);
          Report.map(
            event: 'Установлен комплект снаряжения',
            map: {
              'Комплект': suitStore.suit.name,
            },
          );
          Report.map(
            event: 'Переход на экран комплекта',
            map: {
              'Комплект': suitStore.suit.name,
            },
          );

          Navigator.pop(context);
          context.go(
            '/set',
            extra: currentWeatherStore.weatherDataMap,
          );
        },
        title: Text(
          localWeatherStore.isWeatherLoaded
              ? 'Одеться здесь и сейчас'
              : 'Загрузка текущей локации...',
          style: TextStyle(
            color: localWeatherStore.isWeatherLoaded
                ? Colors.deepOrange
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
