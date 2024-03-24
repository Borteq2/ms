import 'package:mordor_suit/library/config/_config.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:mordor_suit/prebuilt/items.dart';

Suit notSupportedSuit = Suit(
  name: notSupported,
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
  name: frostPunk,
  layer_1: [
    python..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = LayerHelper.mapNumberToName(1, null),
  ],
  layer_2: [
    varan..inSuitLayer = LayerHelper.mapNumberToName(2, null),
  ],
  layer_3: [
    cheburashka..inSuitLayer = LayerHelper.mapNumberToName(3, null),
    uralHoodie..inSuitLayer = LayerHelper.mapNumberToName(3, null),
  ],
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = LayerHelper.mapNumberToName(5, top),
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    saratovTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = LayerHelper.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat..inSuitLayer = LayerHelper.mapNumberToName(10, null),
  ],
  accessories: [
    vaderBalaclava..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    fjordBuff..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    dlanGloves..inSuitLayer = LayerHelper.mapNumberToName(11, null),
  ],
  layer_9: [
    snowmanMaskSuit..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    sugrobBackpackCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    snowballHelmetCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
  ],
);

Suit coldTempSuit = Suit(
  name: cold,
  layer_1: [
    python..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = LayerHelper.mapNumberToName(1, null)
  ],
  layer_2: [
    varan..inSuitLayer = LayerHelper.mapNumberToName(2, null),
  ],
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = LayerHelper.mapNumberToName(5, top),
    cheburashka..inSuitLayer = LayerHelper.mapNumberToName(5, top),
    uralHoodie..inSuitLayer = LayerHelper.mapNumberToName(5, top),
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    saratovTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    citizenTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    uralTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = LayerHelper.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat..inSuitLayer = LayerHelper.mapNumberToName(10, null),
  ],
  accessories: [
    koifBalavlava..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    dozorBuff..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    dlanGloves..inSuitLayer = LayerHelper.mapNumberToName(11, null),
  ],
  layer_9: [
    snowmanMaskSuit..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    sugrobBackpackCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    snowballHelmetCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
  ],
);

Suit belowZeroTempSuit = Suit(
  name: belowZero,
  layer_1: [
    python..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = LayerHelper.mapNumberToName(1, null)
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = LayerHelper.mapNumberToName(5, top),
    cheburashka
      ..inSuitLayer = LayerHelper.mapNumberToName(5, top)
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
    uralHoodie
      ..inSuitLayer = LayerHelper.mapNumberToName(5, top)
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    saratovTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    citizenTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    uralTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(5, bot)
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = LayerHelper.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat..inSuitLayer = LayerHelper.mapNumberToName(10, null),
    peasantUnderhelmet..inSuitLayer = LayerHelper.mapNumberToName(10, null)
  ],
  accessories: [
    koifBalavlava..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    dozorBuff..inSuitLayer = LayerHelper.mapNumberToName(11, null)
  ],
  layer_9: [
    snowmanMaskSuit..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    sugrobBackpackCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    snowballHelmetCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
  ],
);

Suit aboveZeroTempSuit = Suit(
  name: aboveZero,
  layer_1: [
    python..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = LayerHelper.mapNumberToName(1, null)
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = LayerHelper.mapNumberToName(5, top),
    cheburashka
      ..inSuitLayer = LayerHelper.mapNumberToName(5, top)
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
    uralHoodie
      ..inSuitLayer = LayerHelper.mapNumberToName(5, top)
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    saratovTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    citizenTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    uralTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(5, bot)
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = LayerHelper.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat..inSuitLayer = LayerHelper.mapNumberToName(10, null),
    peasantUnderhelmet..inSuitLayer = LayerHelper.mapNumberToName(10, null)
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    vaderBalaclava..inSuitLayer = LayerHelper.mapNumberToName(11, null)
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
  ],
);

Suit lowTempSuit = Suit(
  name: low,
  layer_1: [
    python..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = LayerHelper.mapNumberToName(1, null),
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket..inSuitLayer = LayerHelper.mapNumberToName(5, top),
    cheburashka
      ..inSuitLayer = LayerHelper.mapNumberToName(5, top)
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
    uralHoodie
      ..inSuitLayer = LayerHelper.mapNumberToName(5, top)
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_5_bot: [
    wolfTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    saratovTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    citizenTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
    uralTrousers..inSuitLayer = LayerHelper.mapNumberToName(5, bot),
  ],
  layer_6: [
    inokMembranPoncho..inSuitLayer = LayerHelper.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    peasantUnderhelmet..inSuitLayer = LayerHelper.mapNumberToName(10, null),
    gasBaseball..inSuitLayer = LayerHelper.mapNumberToName(10, null)
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = LayerHelper.mapNumberToName(11, null)
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
  ],
);

Suit warmTempSuit = Suit(
  name: warm,
  layer_1: [
    python..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    instructorShirt..inSuitLayer = LayerHelper.mapNumberToName(1, null),
    soloLongsleave..inSuitLayer = LayerHelper.mapNumberToName(1, null)
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: [
    cheburashka..inSuitLayer = LayerHelper.mapNumberToName(4, top),
    uralHoodie..inSuitLayer = LayerHelper.mapNumberToName(4, top),
  ],
  layer_4_bot: [
    saratovTrousers..inSuitLayer = LayerHelper.mapNumberToName(4, bot),
    citizenTrousers..inSuitLayer = LayerHelper.mapNumberToName(4, bot),
  ],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [
    inokMembranPoncho..inSuitLayer = LayerHelper.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    gasBaseball..inSuitLayer = LayerHelper.mapNumberToName(10, null),
    windPanama..inSuitLayer = LayerHelper.mapNumberToName(10, null)
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = LayerHelper.mapNumberToName(11, null)
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
  ],
);

Suit heatTempSuit = Suit(
  name: heat,
  layer_1: [
    python..inSuitLayer = LayerHelper.mapNumberToName(1, null),
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: [
    saratovJacket..inSuitLayer = LayerHelper.mapNumberToName(4, top),
    instructorShirt..inSuitLayer = LayerHelper.mapNumberToName(4, top),
    soloLongsleave..inSuitLayer = LayerHelper.mapNumberToName(4, top)
  ],
  layer_4_bot: [
    saratovTrousers..inSuitLayer = LayerHelper.mapNumberToName(4, bot),
    citizenTrousers..inSuitLayer = LayerHelper.mapNumberToName(4, bot)
  ],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [
    inokMembranPoncho..inSuitLayer = LayerHelper.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    gasBaseball..inSuitLayer = LayerHelper.mapNumberToName(10, null),
    windPanama..inSuitLayer = LayerHelper.mapNumberToName(10, null),
    neoBandana..inSuitLayer = LayerHelper.mapNumberToName(10, null),
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = LayerHelper.mapNumberToName(11, null),
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
  ],
);

Suit meltingTempSuit = Suit(
  name: melting,
  layer_1: null,
  layer_2: null,
  layer_3: null,
  layer_4_top: [
    saratovJacket..inSuitLayer = LayerHelper.mapNumberToName(4, top),
    instructorShirt..inSuitLayer = LayerHelper.mapNumberToName(4, top),
    soloLongsleave..inSuitLayer = LayerHelper.mapNumberToName(4, top),
    gopTacSet..inSuitLayer = LayerHelper.mapNumberToName(4, top),
    scoutMaskingSet..inSuitLayer = LayerHelper.mapNumberToName(4, top),
  ],
  layer_4_bot: [
    saratovTrousers..inSuitLayer = LayerHelper.mapNumberToName(4, bot),
    freelancerShorts..inSuitLayer = LayerHelper.mapNumberToName(4, bot),
    gopTacSet..inSuitLayer = LayerHelper.mapNumberToName(4, bot),
    scoutMaskingSet..inSuitLayer = LayerHelper.mapNumberToName(4, bot),
  ],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [
    inokMembranPoncho..inSuitLayer = LayerHelper.mapNumberToName(6, null),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    gasBaseball..inSuitLayer = LayerHelper.mapNumberToName(10, null),
    windPanama..inSuitLayer = LayerHelper.mapNumberToName(10, null),
    neoBandana..inSuitLayer = LayerHelper.mapNumberToName(10, null),
  ],
  accessories: [
    ninjaBalaclava..inSuitLayer = LayerHelper.mapNumberToName(11, null),
    raiderBuff..inSuitLayer = LayerHelper.mapNumberToName(11, null),
  ],
  layer_9: [
    frakSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    evokSniperCloak..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    pokrovSniperScarf..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    scoutMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
    vorohMaskCover..inSuitLayer = LayerHelper.mapNumberToName(9, null),
  ],
);
