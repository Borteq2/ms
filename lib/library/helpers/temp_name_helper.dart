import '../../enums/_enums.dart';
import '../config/_config.dart';

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
        return notSupported;
      case TemperatureTypes.frostPunk:
        return frostPunk;
      case TemperatureTypes.cold:
        return cold;
      case TemperatureTypes.belowZero:
        return belowZero;
      case TemperatureTypes.aboveZero:
        return aboveZero;
      case TemperatureTypes.low:
        return low;
      case TemperatureTypes.warm:
        return warm;
      case TemperatureTypes.heat:
        return heat;
      case TemperatureTypes.melting:
        return melting;
    }
  }
}
