import '../../enums/_enums.dart';

class TempHelper {
  static mapTempToTempType({required num temperature}) {
    return temperature >= -15 && temperature < -10
        ? TemperatureTypes.frostPunk
        : temperature >= -10 && temperature < -5
            ? TemperatureTypes.cold
            : temperature >= -5 && temperature < 0
                ? TemperatureTypes.belowZero
                : temperature >= 0 && temperature < 5
                    ? TemperatureTypes.aboveZero
                    : temperature >= 5 && temperature < 10
                        ? TemperatureTypes.low
                        : temperature >= 10 && temperature < 15
                            ? TemperatureTypes.warm
                            : temperature >= 15 && temperature < 20
                                ? TemperatureTypes.heat
                                : temperature > 20
                                    ? TemperatureTypes.melting
                                    : TemperatureTypes.notSupported;
  }

  static mapTempToName({required TemperatureTypes temperature}) {
    switch (temperature) {
      case TemperatureTypes.notSupported:
        return 'Не поддерживается';
      case TemperatureTypes.frostPunk:
        return 'Дубак';
      case TemperatureTypes.cold:
        return 'Холодно';
      case TemperatureTypes.belowZero:
        return 'Чуть ниже нуля';
      case TemperatureTypes.aboveZero:
        return 'Чуть выше нуля';
      case TemperatureTypes.low:
        return 'Прохладно';
      case TemperatureTypes.warm:
        return 'Жарко';
      case TemperatureTypes.heat:
        return 'Очень жарко';
      case TemperatureTypes.melting:
        return 'Жара';
    }
  }
}
