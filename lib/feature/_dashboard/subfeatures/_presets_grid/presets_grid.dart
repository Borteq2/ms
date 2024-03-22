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
  Talker talker = GetIt.I<Talker>();

  void _openSet(int index, BuildContext context) {
    widget.appStore.presetWeatherStore.setSuitByWeatherManually(
      widget.appStore.locationPresetsStore.presetCityWeatherData[index],
    );
    if (kReleaseMode) {
      AppMetrica.reportEventWithMap('Установлен комплект снаряжения',
          {'Комплект': widget.appStore.suitStore.suit.name});
      AppMetrica.reportEvent('Переход на экран комплекта');
    }
    context.go(
      '/set',
      extra: widget.appStore.locationPresetsStore.presetCityWeatherData[index],
    );
  }

  Future<void> _refresh() async {
    talker.critical('presets refresh');
    await widget.appStore.requestPermissionsAndLoadDataIfNeeded();
    await widget.appStore.localWeatherStore.getLocationAndWeatherData();
    // await widget.appStore.weatherPresetsStore.fetchCityWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    Talker talker = GetIt.I<Talker>();
    LocationPresetsStore locationPresetsStore =
        widget.appStore.locationPresetsStore;
    CityNamesStore cityNamesStore = widget.appStore.cityNamesStore;

    reaction(
        (_) =>
            widget.appStore.locationPresetsStore.presetCityWeatherData.length,
        (_) => setState(() {}));

    return Observer(
      builder: (_) => RefreshIndicator(
        onRefresh: () => _refresh(),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: cityNamesStore.presetsCityNamesCount,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      Report.map(
                        event: 'Пресет переведён в режим удаления',
                        map: {
                          'Название': cityNamesStore.presetsCityNames[index]
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
                                  'Локация':
                                      cityNamesStore.presetsCityNames[index]
                                }),
                            setState(() => isLongPressed = !isLongPressed)
                          }
                        : {
                            locationPresetsStore
                                        .presetCityWeatherData[index].name !=
                                    null
                                ? _openSet(index, context)
                                : {
                                    Report.map(
                                        index: index,
                                        event:
                                            'Данные пресета локации не загружены',
                                        map: {
                                          'Локация': locationPresetsStore
                                                  .presetCityWeatherData[index]
                                                  .name ??
                                              'Данные пресета локации не загружены'
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
                    child:
                        locationPresetsStore.presetCityWeatherDataCount > index
                            ? Card(
                                child: isLongPressed && presetIndex == index
                                    ? RemovePresetInfoWidget(
                                        widget: widget,
                                        index: index,
                                        appStore: widget.appStore,
                                      )
                                    : locationPresetsStore
                                                .presetCityWeatherData[index]
                                                .name !=
                                            null
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
