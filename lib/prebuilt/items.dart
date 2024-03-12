import 'package:mordor_suit/feature/library/logic/map_layers.dart';
import 'package:mordor_suit/models/_models.dart';

Clothing noClothing = Clothing(
  name: '',
  linkToStore: '',
  features: [],
  image: '',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

// ============================== 1 ============================================

Clothing python = Clothing(
  name: 'Термобелье влагоотводящее "Питон"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-underwear-python',
  features: [
    'Базовый слой',
    'Отводит влагу от тела',
    'Одевается на голое тело',
    'Состав: 97% полиэфир, 3% эластан',
  ],
  image: 'assets/images/python.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing instructorShirt = Clothing(
  name: 'Футболка "Инструктор"',
  linkToStore: 'https://mordor-tac.com/product/mordortac-t-shirt-instructor',
  features: [
    'Альтернатива базовому слою',
    'Быстро сохнет',
    'Одевается на голое тело',
    'Состав: 92% хлопок, 8% эластан',
  ],
  image: 'assets/images/instructorShirt.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing soloLongsleave = Clothing(
  name: 'Лонгслив "Соло"',
  linkToStore: 'https://mordor-tac.com/product/mordortac-long-sleeve-solo',
  features: [
    'Альтернатива базовому слою',
    'Быстро сохнет',
    'Одевается на голое тело',
    'Состав: 92% хлопок, 8% эластан',
  ],
  image: 'assets/images/soloLongsleave.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

// ============================== 2 ============================================

Clothing varan = Clothing(
  name: 'Термобелье утепляющее "Варан"',
  linkToStore:
      'https://mordor-tac.com/product/MordorTac-mid-weight-thermosuit-varan',
  features: [
    'Базовый утепляющий слой',
    'Отводит влагу от тела и сохраняет тепло',
    'Одевается на первый слой',
    'Состав: 98% полиэстер, 2% эластан',
  ],
  image: 'assets/images/varan.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

// ============================== 3 ============================================

Clothing cheburashka = Clothing(
  name: 'Куртка флисовая "Чебурашка"',
  linkToStore: 'https://mordor-tac.com/product/fleece-jacket-cheburashka',
  features: [
    'Утепляющий слой',
    'Отводит влагу от тела и согревает',
    'Одевается на первый и по необходимости второй слои',
    'Состав: 100% полиэстер',
  ],
  image: 'assets/images/cheburashka.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing uralHoodie = Clothing(
  name: 'Худи "Урал"',
  linkToStore: 'https://mordor-tac.com/product/mordortac-hoodie-ural',
  features: [
    'Утепляющий слой',
    'Отводит влагу от тела и согревает',
    'Одевается на первый и по необходимости второй слои',
    'Состав: 80% хлопок, 20% полиэстер',
  ],
  image: 'assets/images/uralHoodie.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

// ============================== 4 ============================================

Clothing saratovJacket = Clothing(
  name: 'Боевая рубашка "Саратов"',
  linkToStore: 'https://mordor-tac.com/product/light-combat-shirt-SARatov',
  features: [
    'Универсальный летний слой',
    'Высокопрочная дышащая ткань Рип стоп',
    'Одевается поверх всех слоев',
    'Состав: 50% хлопок, 50% полиамид',
  ],
  image: 'assets/images/saratovJacket.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing saratovTrousers = Clothing(
  name: 'Боевые брюки "Саратов"',
  linkToStore:
      'https://mordor-tac.com/product/mordor-tac-summer-trousers-saratov',
  features: [
    'Универсальный летний слой',
    'Высокопрочная дышащая ткань Рип стоп',
    'Одевается поверх всех слоев',
    'Состав: 50% хлопок, 50% полиамид',
  ],
  image: 'assets/images/saratovTrousers.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

// Clothing scoutMaskingCloak = Clothing(
//   name: 'Маскировочный костюм "Скаут"',
//   linkToStore:
//   'https://mordor-tac.com/product/mordortac-summer-masking-suit-scout',
//   features: [],
//   image: 'assets/images/scout.jpg',
//     inSuitLayer: null,
//   isNecessary: true,
//   isHasAlready: false,
// );

// ============================== 5 ============================================

Clothing wolfJacket = Clothing(
  name: 'Демисезонная боевая куртка "Волк"',
  linkToStore:
      'https://mordor-tac.com/product/mordortac-demi-season-combat-jacket-volk',
  features: [
    'Универсальный демисезонный слой',
    'Высокопрочное изделие с базовой ветро-влаго защитой',
    'Одевается поверх всех слоев',
    'Состав: 80% полиэстер, 20% вискоза',
  ],
  image: 'assets/images/wolfJacket.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing wolfTrousers = Clothing(
  name: 'Демисезонная боевые брюки "Волк"',
  linkToStore:
      'https://mordor-tac.com/product/mordortac-demi-season-trousers-volk',
  features: [
    'Универсальный демисезонный слой',
    'Высокопрочное изделие с базовой ветро-влаго защитой',
    'Одевается поверх всех слоев',
    'Состав: 80% полиэстер, 20% вискоза',
  ],
  image: 'assets/images/wolfTrousers.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing citizenTrousers = Clothing(
  name: 'Брюки "Гражданин"',
  linkToStore: 'https://mordor-tac.com/product/trousers-grazhdanin',
  features: [
    'Универсальный демисезонный слой',
    'Эластичный неутепленный софтшел',
    'Высокопрочное изделие с базовой ветро-влаго защитой',
    'Состав: 96% полиамид, 4% эластан',
  ],
  image: 'assets/images/citizenTrousers.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing uralTrousers = Clothing(
  name: 'Брюки "Урал"',
  linkToStore: 'https://mordor-tac.com/product/mordortac-trousers-ural',
  features: [
    'Универсальный демисезонный слой',
    'Отводит влагу от тела и согревает',
    'Одевается поверх всех слоев',
    'Состав: 80% хлопок, 20% полиэстер',
  ],
  image: 'assets/images/uralTrousers.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

// ============================== 6 ============================================

Clothing inokMembranPoncho = Clothing(
  name: 'Мембранное пончо "Инок"',
  linkToStore: 'https://mordor-tac.com/product/membrane-raincoat-poncho-inok',
  features: [
    'Влагозащитный слой',
    'Защищает от дождя и снега',
    'Отводит влагу от тела, но не пропускает ее внутрь',
    'Состав: 100% полиамид',
  ],
  image: 'assets/images/inokMembranPoncho.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

// ============================== 7 ============================================

// ============================== 8 ============================================

// ============================== 9 ============================================
