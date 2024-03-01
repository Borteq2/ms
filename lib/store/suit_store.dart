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
  Suit suit = heatTempSuit;

// =============================================================================

  @computed
  Map<String, int?> get itemsCountByLayer => {
        'layer_1': suit.layer_1?.length ?? 0,
        'layer_2': suit.layer_2?.length ?? 0,
        'layer_3': suit.layer_3?.length ?? 0,
        'layer_4': suit.layer_4?.length ?? 0,
        'layer_4a': suit.layer_4a?.length ?? 0,
        'layer_5': suit.layer_5?.length ?? 0,
        'accessories': suit.accessories.length,
      };

  // @computed
  // int get unEmptyLayersCount => itemsCountByLayer.values
  //     .where((value) => value != 0 && value != null)
  //     .length;

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

  // @computed
  // List<Clothing> get suitClothesListByLayer => List.from(suit.clothes)
  //   ..sort((a, b) => a.inSuitLayer.compareTo(b.inSuitLayer));
  //
  // @computed
  // List<Accessory> get suitAccessoriesList => suit.accessories;
  //
  // @computed
  // List get equipList => [...suitClothesListByLayer, ...suitAccessoriesList];
  //
  // @computed
  // int get equipCount => equipList.length;

// =============================================================================

  @action
  void refreshSuitData() {
    suit = notSupported;
    setSuitByTemperatureType();
  }

  @action
  void setSuitByTemperatureType() {
    talker.info('начинаю парсить температуру');
    switch (appStore.weatherStore.currentTemperatureType) {
      case TemperatureTypes.notSupported:
        suit = notSupported;
      case TemperatureTypes.cold:
        suit = coldTempSuit;
      case TemperatureTypes.low:
        suit = lowTempSuit;
      case TemperatureTypes.warm:
        suit = warmTempSuit;
      case TemperatureTypes.heat:
        suit = heatTempSuit;
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
        case 'layer_4':
          resultMap['4'] = suit.layer_4;
          break;
        case 'layer_4a':
          resultMap['4a'] = suit.layer_4a;
          break;
        case 'layer_5':
          resultMap['5'] = suit.layer_5;
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
