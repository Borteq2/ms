import 'package:flutter/material.dart';

class IconHelper {
  static Icon getIconByWeather(String weather) => weather == 'Clear'
      ? const Icon(Icons.sunny)
      : weather == 'Clouds'
          ? const Icon(Icons.cloud)
          : weather == 'Rain'
              ? const Icon(Icons.water_drop)
              : weather == 'Snow'
                  ? const Icon(Icons.cloudy_snowing)
                  : weather == 'Thunderstorm'
                      ? const Icon(Icons.thunderstorm)
                      : weather == 'Mist'
                          ? const Icon(Icons.waves)
                          : weather == 'Haze'
                              ? const Icon(Icons.waves)
                              : weather == 'Sleet'
                                  ? const Icon(Icons.snowing)
                                  : weather == 'Freezing rain'
                                      ? const Icon(Icons.cloudy_snowing)
                                      : const Icon(Icons.question_mark);
}
