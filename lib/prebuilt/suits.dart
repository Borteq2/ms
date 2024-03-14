import 'package:mordor_suit/feature/library/logic/map_layers.dart';
import 'package:mordor_suit/prebuilt/items.dart';
import 'package:mordor_suit/models/_models.dart';

Suit notSupportedSuit = Suit(
  name: 'Нет подходящего',
  layer_1: null,
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: null,
  layer_7: null,
  layer_8: null,
  head: null,
  accessories: null,
  layer_9: null,
);

Suit frostPunkTempSuit = Suit(
  name: 'Мороз',
  layer_1: [
    python..inSuitLayer = Layer.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = Layer.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = Layer.mapNumberToName(1, null),
  ],
  layer_2: [
    varan..inSuitLayer = Layer.mapNumberToName(2, null),
  ],
  layer_3: [
    cheburashka..inSuitLayer = Layer.mapNumberToName(3, null),
    uralHoodie..inSuitLayer = Layer.mapNumberToName(3, null),
  ],
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = Layer.mapNumberToName(5, 'верх'),
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    saratovTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = Layer.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat..inSuitLayer = Layer.mapNumberToName(10, null),
  ],
  accessories: [
    vaderBalaclava..inSuitLayer = Layer.mapNumberToName(11, null),
    fjordBuff..inSuitLayer = Layer.mapNumberToName(11, null),
    dlanGloves..inSuitLayer = Layer.mapNumberToName(11, null),
  ],
  layer_9: [
    snowmanMaskSuit..inSuitLayer = Layer.mapNumberToName(9, null),
    sugrobBackpackCover..inSuitLayer = Layer.mapNumberToName(9, null),
    snowballHelmetCover..inSuitLayer = Layer.mapNumberToName(9, null),
  ],
);

Suit coldTempSuit = Suit(
  name: 'Очень холодно',
  layer_1: [
    python..inSuitLayer = Layer.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = Layer.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = Layer.mapNumberToName(1, null)
  ],
  layer_2: [
    varan..inSuitLayer = Layer.mapNumberToName(2, null),
  ],
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = Layer.mapNumberToName(5, 'верх'),
    cheburashka..inSuitLayer = Layer.mapNumberToName(5, 'верх'),
    uralHoodie..inSuitLayer = Layer.mapNumberToName(5, 'верх'),
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    saratovTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    citizenTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    uralTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = Layer.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat..inSuitLayer = Layer.mapNumberToName(10, null),
  ],
  accessories: [
    koifBalavlava..inSuitLayer = Layer.mapNumberToName(11, null),
    dozorBuff..inSuitLayer = Layer.mapNumberToName(11, null),
    dlanGloves..inSuitLayer = Layer.mapNumberToName(11, null),
  ],
  layer_9: [
    snowmanMaskSuit..inSuitLayer = Layer.mapNumberToName(9, null),
    sugrobBackpackCover..inSuitLayer = Layer.mapNumberToName(9, null),
    snowballHelmetCover..inSuitLayer = Layer.mapNumberToName(9, null),
  ],
);

Suit belowZeroTempSuit = Suit(
  name: 'Холодно',
  layer_1: [
    python..inSuitLayer = Layer.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = Layer.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = Layer.mapNumberToName(1, null)
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = Layer.mapNumberToName(5, 'верх'),
    cheburashka
      ..inSuitLayer = Layer.mapNumberToName(5, 'верх')
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
    uralHoodie
      ..inSuitLayer = Layer.mapNumberToName(5, 'верх')
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    saratovTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    citizenTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    uralTrousers
      ..inSuitLayer = Layer.mapNumberToName(5, 'низ')
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = Layer.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat..inSuitLayer = Layer.mapNumberToName(10, null),
    peasantUnderhelmet..inSuitLayer = Layer.mapNumberToName(10, null)
  ],
  accessories: [
    koifBalavlava..inSuitLayer = Layer.mapNumberToName(11, null),
    dozorBuff..inSuitLayer = Layer.mapNumberToName(11, null)
  ],
  layer_9: [
    snowmanMaskSuit..inSuitLayer = Layer.mapNumberToName(9, null),
    sugrobBackpackCover..inSuitLayer = Layer.mapNumberToName(9, null),
    snowballHelmetCover..inSuitLayer = Layer.mapNumberToName(9, null),
  ],
);

Suit aboveZeroTempSuit = Suit(
  name: 'Прохладно',
  layer_1: [
    python..inSuitLayer = Layer.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = Layer.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = Layer.mapNumberToName(1, null)
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = Layer.mapNumberToName(5, 'верх'),
    cheburashka
      ..inSuitLayer = Layer.mapNumberToName(5, 'верх')
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
    uralHoodie
      ..inSuitLayer = Layer.mapNumberToName(5, 'верх')
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    saratovTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    citizenTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    uralTrousers
      ..inSuitLayer = Layer.mapNumberToName(5, 'низ')
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = Layer.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat..inSuitLayer = Layer.mapNumberToName(10, null),
    peasantUnderhelmet..inSuitLayer = Layer.mapNumberToName(10, null)
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = Layer.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = Layer.mapNumberToName(11, null),
    vaderBalaclava..inSuitLayer = Layer.mapNumberToName(11, null)
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = Layer.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
  ],
);

Suit lowTempSuit = Suit(
  name: 'Тепло',
  layer_1: [
    python..inSuitLayer = Layer.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = Layer.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = Layer.mapNumberToName(1, null),
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = Layer.mapNumberToName(5, 'верх'),
    saratovTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    cheburashka
      ..inSuitLayer = Layer.mapNumberToName(5, 'верх')
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
    uralHoodie
      ..inSuitLayer = Layer.mapNumberToName(5, 'верх')
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    saratovTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    citizenTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
    uralTrousers..inSuitLayer = Layer.mapNumberToName(5, 'низ'),
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = Layer.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    peasantUnderhelmet..inSuitLayer = Layer.mapNumberToName(10, null),
    gasBaseball..inSuitLayer = Layer.mapNumberToName(10, null)
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = Layer.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = Layer.mapNumberToName(11, null)
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = Layer.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
  ],
);

Suit warmTempSuit = Suit(
  name: 'Жарко',
  layer_1: [
    python..inSuitLayer = Layer.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = Layer.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = Layer.mapNumberToName(1, null)
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: [
    cheburashka..inSuitLayer = Layer.mapNumberToName(4, 'верх'),
    uralHoodie..inSuitLayer = Layer.mapNumberToName(4, 'верх'),
  ],
  layer_4_bot: [
    saratovTrousers..inSuitLayer = Layer.mapNumberToName(4, 'низ'),
    citizenTrousers..inSuitLayer = Layer.mapNumberToName(4, 'низ'),
  ],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [
    inokMembranPoncho..inSuitLayer = Layer.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    gasBaseball..inSuitLayer = Layer.mapNumberToName(10, null),
    windPanama..inSuitLayer = Layer.mapNumberToName(10, null)
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = Layer.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = Layer.mapNumberToName(11, null)
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = Layer.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
  ],
);

Suit heatTempSuit = Suit(
  name: 'Очень жарко',
  layer_1: [
    python..inSuitLayer = Layer.mapNumberToName(1, null),
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: [
    saratovJacket..inSuitLayer = Layer.mapNumberToName(4, 'верх'),
    instructorShirt..inSuitLayer = Layer.mapNumberToName(4, 'верх'),
    soloLongsleave..inSuitLayer = Layer.mapNumberToName(4, 'верх')
  ],
  layer_4_bot: [
    saratovTrousers..inSuitLayer = Layer.mapNumberToName(4, 'низ'),
    citizenTrousers..inSuitLayer = Layer.mapNumberToName(4, 'низ')
  ],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [
    inokMembranPoncho..inSuitLayer = Layer.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    gasBaseball..inSuitLayer = Layer.mapNumberToName(10, null),
    windPanama..inSuitLayer = Layer.mapNumberToName(10, null),
    neoBandana..inSuitLayer = Layer.mapNumberToName(10, null),
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = Layer.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = Layer.mapNumberToName(11, null),
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = Layer.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
  ],
);

Suit meltingTempSuit = Suit(
  name: 'Жара',
  layer_1: null,
  layer_2: null,
  layer_3: null,
  layer_4_top: [
    saratovJacket..inSuitLayer = Layer.mapNumberToName(4, 'верх'),
    instructorShirt..inSuitLayer = Layer.mapNumberToName(4, 'верх'),
    soloLongsleave..inSuitLayer = Layer.mapNumberToName(4, 'верх'),
    gopTacSet..inSuitLayer = Layer.mapNumberToName(4, 'верх'),
    scoutMaskingSet..inSuitLayer = Layer.mapNumberToName(4, 'верх'),
  ],
  layer_4_bot: [
    saratovTrousers..inSuitLayer = Layer.mapNumberToName(4, 'низ'),
    freelancerShorts..inSuitLayer = Layer.mapNumberToName(4, 'низ'),
    gopTacSet..inSuitLayer = Layer.mapNumberToName(4, 'низ'),
    scoutMaskingSet..inSuitLayer = Layer.mapNumberToName(4, 'низ'),
  ],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [
    inokMembranPoncho..inSuitLayer = Layer.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    gasBaseball..inSuitLayer = Layer.mapNumberToName(10, null),
    windPanama..inSuitLayer = Layer.mapNumberToName(10, null),
    neoBandana..inSuitLayer = Layer.mapNumberToName(10, null),
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = Layer.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = Layer.mapNumberToName(11, null),
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = Layer.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = Layer.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = Layer.mapNumberToName(9, null),
  ],
);
