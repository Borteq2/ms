class Layer {
  static String mapNumberToName(int layerNumber, String? topOrBot) => layerNumber ==
          1
      ? topOrBot != null
          ? 'Слой: Базовый ($topOrBot)'
          : 'Слой: Базовый'
      : layerNumber == 2
          ? topOrBot != null
              ? 'Слой: Базовый утепляющий ($topOrBot)'
              : 'Слой: Базовый утепляющий'
          : layerNumber == 3
              ? topOrBot != null
                  ? 'Слой: Утепляющий ($topOrBot)'
                  : 'Слой: Утепляющий'
              : layerNumber == 4
                  ? topOrBot != null
                      ? 'Слой: Универсальный летний ($topOrBot)'
                      : 'Слой: Универсальный летний'
                  : layerNumber == 5
                      ? topOrBot != null
                          ? 'Слой: Универсальный демисезонный ($topOrBot)'
                          : 'Слой: Универсальный демисезонный'
                      : layerNumber == 6
                          ? topOrBot != null
                              ? 'Слой: Влагозащита ($topOrBot)'
                              : 'Слой: Влагозащита'
                          : layerNumber == 7
                              ? topOrBot != null
                                  ? 'Слой: Утеплённый демисезонный ($topOrBot)'
                                  : 'Слой: Утеплённый демисезонный'
                              : layerNumber == 8
                                  ? topOrBot != null
                                      ? 'Слой: Утеплённый зимний ($topOrBot)'
                                      : 'Слой: Утеплённый зимний'
                                  : layerNumber == 9
                                      ? topOrBot != null
                                          ? 'Слой: Маскировка ($topOrBot)'
                                          : 'Слой: Маскировка'
                                      : layerNumber == 10
                                          ? topOrBot != null
                                              ? 'Слой: Головной убор ($topOrBot)'
                                              : 'Головной убор'
                                          : layerNumber == 11
                                              ? topOrBot != null
                                                  ? 'Слой: Аксессуар ($topOrBot)'
                                                  : 'Аксессуар'
                                              : topOrBot != null
                                                  ? 'Слой: Другое ($topOrBot)'
                                                  : 'Другое';
}
