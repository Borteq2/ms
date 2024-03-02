import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/feature/widgets/_widgets.dart';
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
  @override
  Widget build(BuildContext context) {
    reaction(
        (_) => widget.appStore.weatherPresetsStore.presetCityWeatherData.length,
        (_) => setState(() {}));

    return Observer(
      builder: (_) => Column(
        children: [
          Text('Данные обновлены: ${widget.appStore.weatherStore.timestamp}'),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount:
                  widget.appStore.weatherPresetsStore.presetsCityNamesCount,
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
                                'Локация: ${widget.appStore.weatherPresetsStore.presetsCityNames[index]}',
                                overflow: TextOverflow.ellipsis),
                            Text(
                                '${widget.appStore.weatherPresetsStore.presetCityWeatherData[index]['name']}',
                                overflow: TextOverflow.ellipsis),
                            appStore.weatherStore.getIconByWeather(widget
                                    .appStore
                                    .weatherPresetsStore
                                    .presetCityWeatherData[index]['weather'][0]
                                ['main']),
                            Text(
                              widget
                                      .appStore
                                      .weatherPresetsStore
                                      .presetCityWeatherData[index]['weather']
                                          [0]['description']
                                      .toString()[0]
                                      .toUpperCase() +
                                  widget
                                      .appStore
                                      .weatherPresetsStore
                                      .presetCityWeatherData[index]['weather']
                                          [0]['description']
                                      .toString()
                                      .substring(1),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                                'Температура: ${widget.appStore.weatherPresetsStore.presetCityWeatherData[index]['main']['temp']}',
                                overflow: TextOverflow.ellipsis),
                            Text(
                                'Ощущается как: ${widget.appStore.weatherPresetsStore.presetCityWeatherData[index]['main']['feels_like']}',
                                overflow: TextOverflow.ellipsis),
                            Text(
                                'Влажность: ${widget.appStore.weatherPresetsStore.presetCityWeatherData[index]['main']['humidity']}',
                                overflow: TextOverflow.ellipsis),
                            Text(
                                'Ветер: ${widget.appStore.weatherPresetsStore.presetCityWeatherData[index]['wind']['speed']}',
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
