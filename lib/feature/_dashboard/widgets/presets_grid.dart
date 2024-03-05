import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/feature/library/logic/capitalize_first_symbol.dart';
import 'package:mordor_suit/feature/library/logic/map_weather_to_icon.dart';
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
  @override
  Widget build(BuildContext context) {


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
                    crossAxisCount: 2),
                itemCount: widget.appStore.weatherPresetsStore.cityNamesStore
                    .presetsCityNamesCount,
                itemBuilder: (context, index) => GestureDetector(
                  onLongPress: () =>
                      widget.appStore.weatherPresetsStore.removePreset(index),
                  onTap: () => context.go('/set',
                      extra: widget.appStore.weatherPresetsStore
                          .presetCityWeatherData[index]),
                  child: widget.appStore.weatherPresetsStore
                              .presetCityWeatherDataCount >
                          index
                      ? Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                StringHelper.capitalizeFirstSymbol(appStore
                                    .weatherPresetsStore
                                    .description(index)),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  'Температура: ${widget.appStore.weatherPresetsStore.baseTemp(index)}',
                                  overflow: TextOverflow.ellipsis),
                              Text(
                                  'Ощущается как: ${widget.appStore.weatherPresetsStore.feelsLike(index)}',
                                  overflow: TextOverflow.ellipsis),
                              Text(
                                  'Влажность: ${widget.appStore.weatherPresetsStore.humidity(index)}',
                                  overflow: TextOverflow.ellipsis),
                              Text(
                                  'Ветер: ${widget.appStore.weatherPresetsStore.wind(index)}',
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
