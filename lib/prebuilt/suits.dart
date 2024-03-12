import 'package:get_it/get_it.dart';
import 'package:mordor_suit/prebuilt/accessories.dart';
import 'package:mordor_suit/prebuilt/items.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:mordor_suit/store/_stores.dart';

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
  layer_9: null,
  head: null,
  accessories: null,
);

Suit frostPunkTempSuit = Suit(
  name: 'Мороз',
  layer_1: [python, instructorShirt, soloLongsleave],
  layer_2: [varan],
  layer_3: [cheburashka, uralHoodie],
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [wolfJacket],
  layer_5_bot: [wolfTrousers],
  layer_6: [inokMembranPoncho],
  layer_7: null,
  layer_8: null,
  layer_9: null,
  head: [nordHat],
  accessories: [
    vaderBalaclava,
    fjordBuff,
    dlanGloves,
  ],
);

Suit coldTempSuit = Suit(
  name: 'Очень холодно',
  layer_1: [python, instructorShirt, soloLongsleave],
  layer_2: [varan],
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [wolfJacket, cheburashka, uralHoodie],
  layer_5_bot: [wolfTrousers, citizenTrousers, uralTrousers],
  layer_6: [inokMembranPoncho],
  layer_7: null,
  layer_8: null,
  layer_9: null,
  head: [nordHat],
  accessories: [koifBalavlava, dozorBuff, dlanGloves],
);

Suit belowZeroTempSuit = Suit(
  name: 'Холодно',
  layer_1: [python, instructorShirt, soloLongsleave],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [wolfJacket, cheburashka, uralHoodie],
  layer_5_bot: [wolfTrousers, citizenTrousers, uralTrousers],
  layer_6: [inokMembranPoncho],
  layer_7: null,
  layer_8: null,
  layer_9: null,
  head: [nordHat, peasantUnderhelmet],
  accessories: [koifBalavlava, dozorBuff],
);

Suit aboveZeroTempSuit = Suit(
  name: 'Прохладно',
  layer_1: [python, instructorShirt, soloLongsleave],
  layer_2: [varan],
  layer_3: [cheburashka],
  layer_4_top: [saratovJacket],
  layer_4_bot: [saratovTrousers],
  layer_5_top: [wolfJacket],
  layer_5_bot: [wolfTrousers],
  layer_6: [inokMembranPoncho],
  layer_7: null,
  layer_8: null,
  layer_9: null,
  head: null,
  accessories: [
    peasantUnderhelmet,
    ninjaBalaclava,
    raiderBuff,
    vaderBalaclava,
  ],
);

Suit lowTempSuit = Suit(
  name: 'Тепло',
  layer_1: [python, instructorShirt, soloLongsleave],
  layer_2: null,
  layer_3: null,
  layer_4_top: null,
  layer_4_bot: null,
  layer_5_top: [wolfJacket, cheburashka, uralHoodie],
  layer_5_bot: [wolfTrousers, citizenTrousers, uralTrousers],
  layer_6: [inokMembranPoncho],
  layer_7: null,
  layer_8: null,
  layer_9: null,
  head: [peasantUnderhelmet, gasBaseball],
  accessories: [ninjaBalaclava, raiderBuff],
);

Suit warmTempSuit = Suit(
  name: 'Жарко',
  layer_1: [python, instructorShirt, soloLongsleave],
  layer_2: null,
  layer_3: null,
  layer_4_top: [cheburashka, uralHoodie],
  layer_4_bot: [saratovTrousers, citizenTrousers],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [inokMembranPoncho],
  layer_7: null,
  layer_8: null,
  layer_9: null,
  head: [gasBaseball, windPanama],
  accessories: [ninjaBalaclava, raiderBuff],
);

Suit heatTempSuit = Suit(
  name: 'Очень жарко',
  layer_1: [python],
  layer_2: null,
  layer_3: null,
  layer_4_top: [saratovJacket, instructorShirt, soloLongsleave],
  layer_4_bot: [saratovTrousers, citizenTrousers],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [inokMembranPoncho],
  layer_7: null,
  layer_8: null,
  layer_9: null,
  head: [gasBaseball, windPanama, neoBandana],
  accessories: [ninjaBalaclava, raiderBuff],
);

Suit meltingTempSuit = Suit(
  name: 'Жара',
  layer_1: null,
  layer_2: null,
  layer_3: null,
  layer_4_top: [saratovJacket, instructorShirt, soloLongsleave],
  layer_4_bot: [saratovTrousers],
  layer_5_top: null,
  layer_5_bot: null,
  layer_6: [inokMembranPoncho],
  layer_7: null,
  layer_8: null,
  layer_9: null,
  head: [gasBaseball, windPanama, neoBandana],
  accessories: [ninjaBalaclava, raiderBuff],
);
