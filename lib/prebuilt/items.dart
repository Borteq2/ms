import 'package:mordor_suit/models/_models.dart';

Clothing noClothing = Clothing(
  name: '',
  linkToStore: '',
  features: [],
  image: '',
  inSuitLayer: 999,
  isNecessary: false,
  isHasAlready: false,
);

Clothing python = Clothing(
  name: 'Термобелье влагоотводящее "Питон"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-underwear-python',
  features: [
    'Базовый слой',
    'Отводит влагу от тела',
  ],
  image: 'assets/images/python.jpg',
  inSuitLayer: 1,
  isNecessary: true,
  isHasAlready: false,
);
Clothing varan = Clothing(
  name: 'Термобелье утепляющее "Варан"',
  linkToStore:
      'https://mordor-tac.com/product/MordorTac-mid-weight-thermosuit-varan',
  features: [
    'Утепляющий слой',
    'Отводит влагу от тела и сохраняет тепло',
  ],
  image: 'assets/images/varan.jpg',
  inSuitLayer: 2,
  isNecessary: true,
  isHasAlready: false,
);
Clothing cheburashka = Clothing(
  name: 'Куртка флисовая "Чебурашка"',
  linkToStore: 'https://mordor-tac.com/product/fleece-jacket-cheburashka',
  features: [
    'Флисовый утепляющий слой',
    'Может носиться как верхний слой',
  ],
  image: 'assets/images/cheburashka.jpg',
  inSuitLayer: 3,
  isNecessary: true,
  isHasAlready: false,
);

Clothing wolfJacket = Clothing(
  name: 'Демисезонная боевая куртка "Волк"',
  linkToStore:
      'https://mordor-tac.com/product/mordortac-demi-season-combat-jacket-volk',
  features: [
    'Обладает базовой ветро-влагозащитой',
    'Дышащая ткань Рип-Стоп',
  ],
  image: 'assets/images/wolfJacket.jpg',
  inSuitLayer: 5,
  isNecessary: true,
  isHasAlready: false,
);
Clothing wolfTrousers = Clothing(
  name: 'Демисезонные брюки "Волк"',
  linkToStore:
      'https://mordor-tac.com/product/mordortac-demi-season-trousers-volk',
  features: [
    'Обладает базовой ветро-влагозащитой',
    'Дышащая ткань Рип-Стоп',
  ],
  image: 'assets/images/wolfTrousers.jpg',
  inSuitLayer: 5,
  isNecessary: true,
  isHasAlready: false,
);

Clothing saratovJacket = Clothing(
  name: 'Боевая рубашка "САРатов"',
  linkToStore: 'https://mordor-tac.com/product/light-combat-shirt-SARatov',
  features: [
    'Отлично отводит влагу от тела',
    'Сделана из Рип-Стопа',
  ],
  image: 'assets/images/saratovJacket.jpg',
  inSuitLayer: 4,
  isNecessary: true,
  isHasAlready: false,
);
Clothing saratovTrousers = Clothing(
  name: 'Летние брюки "САРатов"',
  linkToStore:
      'https://mordor-tac.com/product/mordor-tac-summer-trousers-saratov',
  features: [
    'Прочные и отлично дышат',
    'Сделаны из Рип Стопа',
  ],
  image: 'assets/images/saratovTrousers.jpg',
  inSuitLayer: 4,
  isNecessary: true,
  isHasAlready: false,
);

Clothing scoutMaskingCloak = Clothing(
  name: 'Маскировочный костюм "Скаут"',
  linkToStore: '',
  features: [],
  image: '',
  inSuitLayer: 4,
  isNecessary: true,
  isHasAlready: false,
);

Accessory nordHat = Accessory(
  name: 'Шапка флисовая "Норд"',
  linkToStore: 'https://mordor-tac.com/product/mordortac-fleece-hat-nord',
  features: [],
  image: 'assets/images/nordHat.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Accessory fjordBuff = Accessory(
  name: 'Зимний флисовый бафф "Фьорд"',
  linkToStore: 'https://mordor-tac.com/product/mordorta-buff-fjord',
  features: [],
  image: 'assets/images/fjordBuff.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);
Accessory dozorBuff = Accessory(
  name: 'Бафф демисезонный "Дозор"',
  linkToStore: 'https://mordor-tac.com/product/mordortacfleece-buff-dozor',
  features: [],
  image: 'assets/images/dozorBuff.png',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);
Accessory raiderBuff = Accessory(
  name: 'Бафф "Рейдер"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-buff-raider',
  features: [],
  image: 'assets/images/raiderBuff.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);
Accessory windPanama = Accessory(
  name: 'Панама "Ветер"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-panama-veter',
  features: [],
  image: 'assets/images/windPanama.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Accessory peasantUnderhelmet = Accessory(
  name: 'Шапка-подшлемник "Пизант"',
  linkToStore: 'https://mordor-tac.com/product/hat-liner-peasant',
  features: [],
  image: 'assets/images/peasantUnderhelmet.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Accessory vaderBalaclava = Accessory(
  name: 'Зимняя флисовая балаклава "Вейдер"',
  linkToStore:
      'https://mordor-tac.com/product/mordortac-winter-balaclava-vader',
  features: [],
  image: 'assets/images/vaderBalaclava.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);
Accessory koifBalavlava = Accessory(
  name: 'Демисезонная балаклава "Койф"',
  linkToStore: 'https://mordor-tac.com/product/MordorTac-winter-balaclava-coif',
  features: [],
  image: 'assets/images/koifBalaclava.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);
Accessory ninjaBalaclava = Accessory(
  name: 'Балаклава "Ниндзя"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-balaclava-ninja',
  features: [],
  image: 'assets/images/ninjaBalaclava.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);
