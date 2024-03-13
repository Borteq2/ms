import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/prebuilt/suits.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'suit_store.g.dart';

AppStore appStore = GetIt.I<AppStore>();

class SuitStore = _SuitStore with _$SuitStore;

abstract class _SuitStore with Store {
  _SuitStore({
    required this.talker,
  });

  final Talker talker;

  @observable
  Suit suit = notSupportedSuit;

// =============================================================================

  List<String> layer6Weathers = [
    'Снег',
    'Небольшой снег',
    'Сильный снег',
    'Слякоть',
    'Дождь',
    'Гроза',
    'Шторм',
  ];


  @computed
  bool get isNeedToLayer6 =>
      layer6Weathers.contains(appStore.currentWeatherStore.weather);

  @computed
  Map<String, int?> get itemsCountByLayer => {
        'layer_1': suit.layer_1?.length ?? 0,
        'layer_2': suit.layer_2?.length ?? 0,
        'layer_3': suit.layer_3?.length ?? 0,
        'layer_4_top': suit.layer_4_top?.length ?? 0,
        'layer_4_bot': suit.layer_4_bot?.length ?? 0,
        'layer_5_top': suit.layer_5_top?.length ?? 0,
        'layer_5_bot': suit.layer_5_bot?.length ?? 0,
        'layer_6': isNeedToLayer6 ? suit.layer_6?.length ?? 0 : 0,
        'layer_7': suit.layer_7?.length ?? 0,
        'layer_8': suit.layer_8?.length ?? 0,
        'layer_9': suit.layer_9?.length ?? 0,
        'head': suit.head?.length ?? 0,
        'accessories': suit.accessories?.length ?? 0,
      };

  @computed
  Map<String, int> get layersWithItems =>
      Map.from(itemsCountByLayer)..removeWhere((key, value) => value == 0);

  @computed
  int get layersWithItemsCount => layersWithItems.length;

  @computed
  List<String> get layersWithItemsNames => List.from(layersWithItems.keys);

  @computed
  List<int> get layersWithItemsItemCount => List.from(layersWithItems.values);

  @computed
  Map<String, int> get layersAndItemCountMap =>
      Map.fromIterables(layersWithItemsNames, layersWithItemsItemCount);

  @computed
  Map<String, dynamic> get resultMap =>
      mapFromLayersWithItemsNames(suit, layersWithItemsNames);

// =============================================================================

  @action
  void refreshSuitData() {
    suit = notSupportedSuit;
    setSuitByTemperatureType();
  }

  @action
  void setSuitByTemperatureType() {
    talker.info('начинаю парсить температуру');
    switch (appStore.currentWeatherStore.currentTemperatureType) {
      case TemperatureTypes.notSupported:
        suit = notSupportedSuit;
      case TemperatureTypes.frostPunk:
        suit = frostPunkTempSuit;
      case TemperatureTypes.cold:
        suit = coldTempSuit;
      case TemperatureTypes.belowZero:
        suit = belowZeroTempSuit;
      case TemperatureTypes.aboveZero:
        suit = aboveZeroTempSuit;
      case TemperatureTypes.low:
        suit = lowTempSuit;
      case TemperatureTypes.warm:
        suit = warmTempSuit;
      case TemperatureTypes.heat:
        suit = heatTempSuit;
      case TemperatureTypes.melting:
        suit = meltingTempSuit;
    }
    talker.warning(suit.name);
  }

// =============================================================================

  Map<String, dynamic> mapFromLayersWithItemsNames(
      Suit suit, List<String> layersWithItemsNames) {
    Map<String, dynamic> resultMap = {};

    for (String layerName in layersWithItemsNames) {
      switch (layerName) {
        case 'layer_1':
          resultMap['1'] = suit.layer_1;
          break;
        case 'layer_2':
          resultMap['2'] = suit.layer_2;
          break;
        case 'layer_3':
          resultMap['3'] = suit.layer_3;
          break;
        case 'layer_4_top':
          resultMap['4_top'] = suit.layer_4_top;
          break;
        case 'layer_4_bot':
          resultMap['4_bot'] = suit.layer_4_bot;
          break;
        case 'layer_5_top':
          resultMap['5_top'] = suit.layer_5_top;
          break;
        case 'layer_5_bot':
          resultMap['5_bot'] = suit.layer_5_bot;
          break;
        case 'layer_6':
          resultMap['6'] = suit.layer_6;
          break;
        case 'layer_7':
          resultMap['7'] = suit.layer_7;
          break;
        case 'layer_8':
          resultMap['8'] = suit.layer_8;
          break;
        case 'layer_9':
          resultMap['9'] = suit.layer_9;
          break;
        case 'head':
          resultMap['head'] = suit.head;
          break;
        case 'accessories':
          resultMap['accessories'] = suit.accessories;
          break;
        default:
          break;
      }
    }
    return resultMap;
  }
}
