class Layer {
  static String mapNumberToName(int layerNumber) => layerNumber == 1
      ? 'Базовый'
      : layerNumber == 2
          ? 'Базовый утепляющий'
          : layerNumber == 3
              ? 'Утепляющий'
              : layerNumber == 4
                  ? 'Универсальный летний'
                  : layerNumber == 5
                      ? 'Универсальный демисезонный'
                      : layerNumber == 6
                          ? 'Влагозащита'
                          : layerNumber == 7
                              ? 'Утеплённый демисезонный'
                              : layerNumber == 8
                                  ? 'Утеплённый зимний'
                                  : layerNumber == 9
                                      ? 'Маскировка'
                                      : 'Другое';
}
