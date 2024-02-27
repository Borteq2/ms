import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/feature/prebuilt/suits.dart';
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
  Suit suit = Suit(name: '', clothes: [], accessories: []);

// =============================================================================

  @computed
  List<Clothing> get suitClothesListByLayer => List.from(suit.clothes)
    ..sort((a, b) => a.inSuitLayer.compareTo(b.inSuitLayer));

  @computed
  List<Accessory> get suitAccessoriesList => suit.accessories;

  @computed
  List get equipList => [...suitClothesListByLayer, ...suitAccessoriesList];

  @computed
  int get equipCount => equipList.length;

// =============================================================================

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

// func
}
