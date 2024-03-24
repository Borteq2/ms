import '../config/_config.dart';

class LayerHelper {
  static String mapNumberToName({
    required int layerNumber,
    required String? topOrBot,
  }) =>
      layerNumber == 1
          ? topOrBot != null
              ? 'Слой: $baseLayer ($topOrBot)'
              : 'Слой: $baseLayer'
          : layerNumber == 2
              ? topOrBot != null
                  ? 'Слой: $baseWarmingLayer ($topOrBot)'
                  : 'Слой: $baseWarmingLayer'
              : layerNumber == 3
                  ? topOrBot != null
                      ? 'Слой: $warmingLayer ($topOrBot)'
                      : 'Слой: $warmingLayer'
                  : layerNumber == 4
                      ? topOrBot != null
                          ? 'Слой: $universalSummerLayer ($topOrBot)'
                          : 'Слой: $universalSummerLayer'
                      : layerNumber == 5
                          ? topOrBot != null
                              ? 'Слой: $universalDemiSeasonLayer ($topOrBot)'
                              : 'Слой: $universalDemiSeasonLayer'
                          : layerNumber == 6
                              ? topOrBot != null
                                  ? 'Слой: $humidityShieldLayer ($topOrBot)'
                                  : 'Слой: $humidityShieldLayer'
                              : layerNumber == 7
                                  ? topOrBot != null
                                      ? 'Слой: $warmedDemiSeasonLayer ($topOrBot)'
                                      : 'Слой: $warmedDemiSeasonLayer'
                                  : layerNumber == 8
                                      ? topOrBot != null
                                          ? 'Слой: $universalWinterLayer ($topOrBot)'
                                          : 'Слой: $universalWinterLayer'
                                      : layerNumber == 9
                                          ? topOrBot != null
                                              ? 'Слой: $maskingLayer ($topOrBot)'
                                              : 'Слой: $maskingLayer'
                                          : layerNumber == 10
                                              ? topOrBot != null
                                                  ? 'Слой: $headLayer ($topOrBot)'
                                                  : headLayer
                                              : layerNumber == 11
                                                  ? topOrBot != null
                                                      ? 'Слой: $accessoryLayer ($topOrBot)'
                                                      : accessoryLayer
                                                  : topOrBot != null
                                                      ? 'Слой: $otherLayer ($topOrBot)'
                                                      : otherLayer;
}
