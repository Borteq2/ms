import 'package:mordor_suit/library/config/_config.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:mordor_suit/prebuilt/clothings.dart';

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
    python
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    instructorShirt
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    soloLongsleave
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
  ],
  layer_2: [
    varan
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 2,
        topOrBot: null,
      ),
  ],
  layer_3: [
    cheburashka
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 3,
        topOrBot: null,
      ),
    uralHoodie
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 3,
        topOrBot: null,
      ),
  ],
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      ),
  ],
  layer_5_bot: [
    wolfTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    saratovTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
  ],
  layer_6: [
    inokMembranPoncho
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 6,
        topOrBot: null,
      ),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
  ],
  accessories: [
    vaderBalaclava
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    fjordBuff
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    dlanGloves
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
  ],
  layer_9: [
    snowmanMaskSuit
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    sugrobBackpackCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    snowballHelmetCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
  ],
);

Suit coldTempSuit = Suit(
  name: cold,
  layer_1: [
    python
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    instructorShirt
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    soloLongsleave
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      )
  ],
  layer_2: [
    varan
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 2,
        topOrBot: null,
      ),
  ],
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      ),
    cheburashka
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      ),
    uralHoodie
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      ),
  ],
  layer_5_bot: [
    wolfTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    saratovTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    citizenTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    uralTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
  ],
  layer_6: [
    inokMembranPoncho
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 6,
        topOrBot: null,
      ),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
  ],
  accessories: [
    koifBalavlava
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    dozorBuff
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    dlanGloves
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
  ],
  layer_9: [
    snowmanMaskSuit
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    sugrobBackpackCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    snowballHelmetCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
  ],
);

Suit belowZeroTempSuit = Suit(
  name: belowZero,
  layer_1: [
    python
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    instructorShirt
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    soloLongsleave
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      )
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      ),
    cheburashka
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      )
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
    uralHoodie
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      )
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_5_bot: [
    wolfTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    saratovTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    citizenTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    uralTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      )
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_6: [
    inokMembranPoncho
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 6,
        topOrBot: null,
      ),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
    peasantUnderhelmet
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      )
  ],
  accessories: [
    koifBalavlava
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    dozorBuff
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      )
  ],
  layer_9: [
    snowmanMaskSuit
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    sugrobBackpackCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    snowballHelmetCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
  ],
);

Suit aboveZeroTempSuit = Suit(
  name: aboveZero,
  layer_1: [
    python
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    instructorShirt
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    soloLongsleave
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      )
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      ),
    cheburashka
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      )
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
    uralHoodie
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      )
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_5_bot: [
    wolfTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    saratovTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    citizenTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    uralTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      )
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_6: [
    inokMembranPoncho
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 6,
        topOrBot: null,
      ),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    nordHat
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
    peasantUnderhelmet
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      )
  ],
  accessories: [
    ninjaBalaclava
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    raiderBuff
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    vaderBalaclava
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      )
  ],
  layer_9: [
    frakSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    evokSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    pokrovSniperScarf
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    scoutMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    vorohMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
  ],
);

Suit lowTempSuit = Suit(
  name: low,
  layer_1: [
    python
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    instructorShirt
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    soloLongsleave
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [
    wolfJacket
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      ),
    cheburashka
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      )
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
    uralHoodie
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: top,
      )
      ..features[0] = 'Универсальный демизонный слой'
      ..features[2] = 'Надевается поверх всех слоев',
  ],
  layer_5_bot: [
    wolfTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    saratovTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    citizenTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
    uralTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 5,
        topOrBot: bot,
      ),
  ],
  layer_6: [
    inokMembranPoncho
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 6,
        topOrBot: null,
      ),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    peasantUnderhelmet
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
    gasBaseball
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      )
  ],
  accessories: [
    ninjaBalaclava
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    raiderBuff
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      )
  ],
  layer_9: [
    frakSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    evokSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    pokrovSniperScarf
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    scoutMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    vorohMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
  ],
);

Suit warmTempSuit = Suit(
  name: warm,
  layer_1: [
    python
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    instructorShirt
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
    soloLongsleave
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      )
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: [
    cheburashka
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      ),
    uralHoodie
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      ),
  ],
  layer_4_bot: [
    saratovTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: bot,
      ),
    citizenTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: bot,
      ),
  ],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [
    inokMembranPoncho
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 6,
        topOrBot: null,
      ),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    gasBaseball
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
    windPanama
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      )
  ],
  accessories: [
    ninjaBalaclava
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    raiderBuff
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      )
  ],
  layer_9: [
    frakSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    evokSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    pokrovSniperScarf
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    scoutMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    vorohMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
  ],
);

Suit heatTempSuit = Suit(
  name: heat,
  layer_1: [
    python
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 1,
        topOrBot: null,
      ),
  ],
  layer_2: null,
  layer_3: null,
  layer_4_top: [
    saratovJacket
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      ),
    instructorShirt
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      ),
    soloLongsleave
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      )
  ],
  layer_4_bot: [
    saratovTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: bot,
      ),
    citizenTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: bot,
      )
  ],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [
    inokMembranPoncho
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 6,
        topOrBot: null,
      ),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    gasBaseball
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
    windPanama
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
    neoBandana
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
  ],
  accessories: [
    ninjaBalaclava
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    raiderBuff
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
  ],
  layer_9: [
    frakSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    evokSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    pokrovSniperScarf
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    scoutMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    vorohMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
  ],
);

Suit meltingTempSuit = Suit(
  name: melting,
  layer_1: null,
  layer_2: null,
  layer_3: null,
  layer_4_top: [
    saratovJacket
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      ),
    instructorShirt
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      ),
    soloLongsleave
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      ),
    gopTacSet
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      ),
    scoutMaskingSet
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: top,
      ),
  ],
  layer_4_bot: [
    saratovTrousers
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: bot,
      ),
    freelancerShorts
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: bot,
      ),
    gopTacSet
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: bot,
      ),
    scoutMaskingSet
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 4,
        topOrBot: bot,
      ),
  ],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [
    inokMembranPoncho
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 6,
        topOrBot: null,
      ),
  ],
  layer_7: null,
  layer_8: null,
  head: [
    gasBaseball
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
    windPanama
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
    neoBandana
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 10,
        topOrBot: null,
      ),
  ],
  accessories: [
    ninjaBalaclava
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
    raiderBuff
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 11,
        topOrBot: null,
      ),
  ],
  layer_9: [
    frakSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    evokSniperCloak
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    pokrovSniperScarf
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    scoutMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
    vorohMaskCover
      ..inSuitLayer = LayerHelper.mapNumberToName(
        layerNumber: 9,
        topOrBot: null,
      ),
  ],
);
