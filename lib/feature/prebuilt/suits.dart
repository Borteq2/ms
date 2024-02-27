import 'package:mordor_suit/feature/prebuilt/items.dart';
import 'package:mordor_suit/models/_models.dart';

Suit notSupported = Suit(
  name: 'Нет подходящего',
  clothes: [],
  accessories: [],
);

Suit coldTempSuit = Suit(
  name: 'На мороз',
  clothes: [
    python,
    varan,
    cheburashka,
    wolfJacket,
    wolfTrousers,
  ],
  accessories: [
    nordHat,
    vaderBalaclava,
    fjordBuff,
  ],
);
Suit lowTempSuit = Suit(
  name: 'На прохладу',
  clothes: [
    python,
    varan,
    cheburashka..isNecessary = false,
    saratovShirt..isNecessary = false,
    saratovTrousers..isNecessary = false,
    wolfJacket,
    wolfTrousers,
  ],
  accessories: [
    nordHat,
    koifBalavlava,
    dozorBuff,
  ],
);
Suit warmTempSuit = Suit(
  name: 'Облегчённый',
  clothes: [
    python,
    varan..isNecessary = false,
    cheburashka..isNecessary = false,
    saratovShirt,
    saratovTrousers,
    scoutMaskingCloak..isNecessary = false,
    wolfJacket,
    wolfTrousers,
  ],
  accessories: [
    peasantUnderhelmet,
    ninjaBalaclava,
    raiderBuff,
  ],
);
Suit heatTempSuit = Suit(
  name: 'Лёгкий',
  clothes: [
    python,
    saratovShirt,
    saratovTrousers,
    scoutMaskingCloak,
  ],
  accessories: [
    ninjaBalaclava,
    raiderBuff,
  ],
);
