import 'package:mordor_suit/feature/prebuilt/items.dart';
import 'package:mordor_suit/models/_models.dart';

Suit notSupported = Suit(
  name: 'Нет подходящего',
  layer_1: null,
  layer_2: null,
  layer_3: null,
  layer_4: null,
  layer_4a: null,
  layer_5: null,
  accessories: [],
);

Suit coldTempSuit = Suit(
  name: 'На мороз',
  layer_1: [python],
  layer_2: [varan],
  layer_3: [cheburashka],
  layer_4: null,
  layer_4a: null,
  layer_5: [
    wolfJacket,
    wolfTrousers,
  ],
  accessories: [
    nordHat,
    fjordBuff,
    vaderBalaclava,
  ],
);

Suit lowTempSuit = Suit(
  name: 'На прохладу',
  layer_1: [python],
  layer_2: [varan],
  layer_3: [cheburashka..isNecessary = false],
  layer_4: null,
  layer_4a: null,
  layer_5: [
    wolfJacket,
    wolfTrousers,
  ],
  accessories: [
    peasantUnderhelmet,
    dozorBuff,
    koifBalavlava,
    nordHat,
  ],
);

Suit warmTempSuit = Suit(
  name: 'Облегчённый',
  layer_1: [python],
  layer_2: [varan..isNecessary = false],
  layer_3: [cheburashka..isNecessary = false],
  layer_4: [
    saratovJacket,
    saratovTrousers,
  ],
  layer_4a: [scoutMaskingCloak..isNecessary = false],
  layer_5: [
    wolfJacket..isNecessary = false,
    wolfTrousers..isNecessary = false,
  ],
  accessories: [
    peasantUnderhelmet,
    ninjaBalaclava,
    raiderBuff,
    vaderBalaclava,
  ],
);

Suit heatTempSuit = Suit(
  name: 'Лёгкий',
  layer_1: [python],
  layer_2: null,
  layer_3: null,
  layer_4: [
    saratovJacket,
    saratovTrousers,
  ],
  layer_4a: [scoutMaskingCloak],
  layer_5: null,
  accessories: [
    peasantUnderhelmet,
    ninjaBalaclava,
    raiderBuff,
    windPanama,
  ],
);
