import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/library/config/hive_types.dart';

part 'weather_preset.g.dart';

@HiveType(typeId: weather)
@JsonSerializable()
class WeatherPreset extends _WeatherPreset with _$WeatherPreset {
  WeatherPreset({
    required List<Map<String, dynamic>>? weather,
    required Map<String, dynamic>? main,
    required Map<String, dynamic>? wind,
    required String? name,
  }) : super(
          weather: weather,
          main: main,
          wind: wind,
          name: name,
        );

  factory WeatherPreset.fromJson(Map<String, dynamic> json) =>
      _$WeatherPresetFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherPresetToJson(this);
}

abstract class _WeatherPreset with Store {
  _WeatherPreset({
    required this.weather,
    required this.main,
    required this.wind,
    required this.name,
  });

  @HiveField(0)
  @observable
  List<Map<String, dynamic>>? weather;

  @HiveField(1)
  @observable
  Map<String, dynamic>? main;

  @HiveField(2)
  @observable
  Map<String, dynamic>? wind;

  @HiveField(3)
  @observable
  String? name;
}
