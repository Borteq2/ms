import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import 'package:mordor_suit/feature/library/logic/capitalize_first_symbol.dart';
import 'package:mordor_suit/feature/library/logic/map_weather_to_icon.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PresetsGridWidget extends StatefulWidget {
  const PresetsGridWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  State<PresetsGridWidget> createState() => _PresetsGridWidgetState();
}

class _PresetsGridWidgetState extends State<PresetsGridWidget> {
  bool isLongPressed = false;
  int? presetIndex;

  @override
  Widget build(BuildContext context) {
    Talker talker = GetIt.I<Talker>();

    reaction(
        (_) => widget.appStore.weatherPresetsStore.presetCityWeatherData.length,
        (_) => setState(() {}));

    return Observer(
      builder: (_) => RefreshIndicator(
        onRefresh: () => appStore.weatherPresetsStore.fetchCityWeatherData(),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: widget.appStore.weatherPresetsStore.cityNamesStore
                    .presetsCityNamesCount,
                itemBuilder: (context, index) {
                  if (kReleaseMode) {
                    if (widget.appStore.weatherPresetsStore
                            .presetCityWeatherData[index]['name'] ==
                        'Ошибка загрузки') {
                      AppMetrica.reportEventWithMap(
                        'Данные пресета локации не загружены',
                        {
                          'Локация': widget.appStore.weatherPresetsStore
                              .presetCityWeatherData[index]['name'],
                        },
                      );
                    }
                  }
                  return GestureDetector(
                    onLongPress: () {
                      if (kReleaseMode) {
                        AppMetrica.reportEvent(
                            'Пресет ${widget.appStore.weatherPresetsStore.cityNamesStore.presetsCityNames[index]} переведён в режим удаления');
                      }
                      setState(() {
                        isLongPressed = !isLongPressed;
                        presetIndex = index;
                      });
                    },
                    onTap: () => isLongPressed
                        ? {
                            if (kReleaseMode)
                              {
                                AppMetrica.reportEventWithMap(
                                    'Удаление пресета локации отменено', {
                                  'Локация': widget.appStore.weatherPresetsStore
                                      .cityNamesStore.presetsCityNames[index]
                                })
                              },
                            setState(() => isLongPressed = !isLongPressed)
                          }
                        : {
                            widget.appStore.weatherPresetsStore
                                        .presetCityWeatherData[index]['name'] !=
                                    'Ошибка загрузки'
                                ? _openSet(index, context)
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Данные не загружены, пересоздайте'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  )
                          },
                    child: widget.appStore.weatherPresetsStore
                                .presetCityWeatherDataCount >
                            index
                        ? Card(
                            child: isLongPressed && presetIndex == index
                                ? Center(
                                    child: IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        if (kReleaseMode) {
                                          AppMetrica.reportEventWithMap(
                                              'Удаление пресета', {
                                            widget
                                                    .appStore
                                                    .weatherPresetsStore
                                                    .cityNamesStore
                                                    .presetsCityNames[index]:
                                                '${widget.appStore.weatherPresetsStore.presetCityWeatherData[index]}'
                                          });
                                        }
                                        appStore.weatherPresetsStore
                                            .removePreset(index);
                                      },
                                      icon: const Icon(Icons.delete_forever),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : widget.appStore.weatherPresetsStore
                                                .presetCityWeatherData[index]
                                            ['name'] !=
                                        'Ошибка загрузки'
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Spacer(),
                                          Text(
                                              'Локация: ${widget.appStore.weatherPresetsStore.cityNamesStore.presetsCityNames[index]}',
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              '${widget.appStore.weatherPresetsStore.presetCityWeatherData[index]['name']}',
                                              overflow: TextOverflow.ellipsis),
                                          IconHelper.getIconByWeather(widget
                                              .appStore.weatherPresetsStore
                                              .weather(index)),
                                          Text(
                                            StringHelper.capitalizeFirstSymbol(
                                                appStore.weatherPresetsStore
                                                    .description(index)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                              'Температура: ${widget.appStore.weatherPresetsStore.baseTemp(index)}°С',
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              'Ощущается как: ${widget.appStore.weatherPresetsStore.feelsLike(index)}°С',
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              'Влажность: ${widget.appStore.weatherPresetsStore.humidity(index)}%',
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              'Ветер: ${widget.appStore.weatherPresetsStore.wind(index)} м/с',
                                              overflow: TextOverflow.ellipsis),
                                          const Spacer(),
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Spacer(),
                                          const Text('Ошибка загрузки'),
                                          Text(
                                            'Город ${widget.appStore.weatherPresetsStore.cityNamesStore.presetsCityNames[index]} не найден',
                                            maxLines: 5,
                                            textAlign: TextAlign.center,
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSet(int index, BuildContext context) {
    widget.appStore.currentWeatherStore.setSuitByWeatherManually(
      widget.appStore.weatherPresetsStore.presetCityWeatherData[index],
    );
    if (kReleaseMode) {
      AppMetrica.reportEventWithMap('Установлен комплект снаряжения',
          {'Комплект': widget.appStore.suitStore.suit.name});
      AppMetrica.reportEvent('Переход на экран комплекта');
    }
    context.go(
      '/set',
      extra: widget.appStore.weatherPresetsStore.presetCityWeatherData[index],
    );
  }
}
