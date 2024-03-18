import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/feature/_dashboard/subfeatures/_presets_grid/_widgets.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:mordor_suit/store/_stores.dart';

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

  @override
  Widget build(BuildContext context) {
    Talker talker = GetIt.I<Talker>();
    WeatherPresetsStore presetsStore = widget.appStore.weatherPresetsStore;

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
                itemCount: presetsStore.cityNamesStore.presetsCityNamesCount,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      Report.map(
                        event: 'Пресет переведён в режим удаления',
                        map: {
                          'Название': presetsStore
                              .cityNamesStore.presetsCityNames[index]
                        },
                      );

                      setState(() {
                        isLongPressed = !isLongPressed;
                        presetIndex = index;
                      });
                    },
                    onTap: () => isLongPressed
                        ? {
                            Report.map(
                                index: index,
                                event: 'Удаление пресета локации отменено',
                                map: {
                                  'Локация': presetsStore
                                      .cityNamesStore.presetsCityNames[index]
                                }),
                            setState(() => isLongPressed = !isLongPressed)
                          }
                        : {
                            presetsStore.presetCityWeatherData[index]['name'] !=
                                    'Ошибка загрузки'
                                ? _openSet(index, context)
                                : {
                                    Report.map(
                                        index: index,
                                        event:
                                            'Данные пресета локации не загружены',
                                        map: {
                                          'Локация': presetsStore
                                                  .presetCityWeatherData[index]
                                              ['name']
                                        }),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Данные не загружены, обновите или пересоздайте'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    )
                                  }
                          },
                    child: presetsStore.presetCityWeatherDataCount > index
                        ? Card(
                            child: isLongPressed && presetIndex == index
                                ? RemovePresetInfoWidget(
                                    widget: widget,
                                    index: index,
                                    appStore: widget.appStore,
                                  )
                                : presetsStore.presetCityWeatherData[index]
                                            ['name'] !=
                                        'Ошибка загрузки'
                                    ? CorrectPresetInfoWidget(
                                        widget: widget,
                                        index: index,
                                        appStore: widget.appStore,
                                      )
                                    : ErrorPresetInfoWidget(
                                        widget: widget,
                                        index: index,
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
}
