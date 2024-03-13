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

// =========================== underwear =======================================

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

// ============================ shirts =========================================

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

// =========================== jackets =========================================

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

// ============================ pants ==========================================

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

Clothing freelancerShorts = Clothing(
  name: 'Шорты "Фрилансер"',
  linkToStore:
  'https://mordor-tac.com/product/mordor-tac-shorts-freelancer',
  features: [
    'Легкие шорты из сорочечной ткани',
    'Дышащая ткань, быстро сохнут',
    'Эластичная вставка в поясе',
    'Состав: 65% полиэстер, 35% вискоза',
  ],
  image: 'assets/images/freelancerShorts.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

// =========================== cloaks ==========================================

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

Clothing snowmanMaskSuit = Clothing(
  name: 'Маскировочный костюм «Снеговик»',
  linkToStore: '',
  features: [
    'Ткань не замерзает и не шуршит',
    'Костюм состоящий из брюк, куртки, жилета и мешка',
    'Состав: 100% полиэстер',
  ],
  image: '',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing sugrobBackpackCover = Clothing(
  name: 'Чехол для рюкзака «Сугроб»',
  linkToStore: '',
  features: [
    'Ткань не замерзает и не шуршит',
    'Чехол для рюкзака объемом до 45 литров',
    'Состав: 100% полиэстер',
  ],
  image: '',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing snowballHelmetCover = Clothing(
  name: 'Чехол для шлема «Снежок»',
  linkToStore: '',
  features: [
    'Ткань не замерзает и не шуршит',
    'Подходит для любого шлема',
    'Состав: 100% полиэстер',
  ],
  image: '',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing frakSniperCloak = Clothing(
  name: 'Снайперская накидка «Фрак»',
  linkToStore: '',
  features: [
    'Маскировочная накидка с сеточной основой и нашитыми листьями',
    'Полноразмерная накидка, маскирующая ростовую фигуру',
    'Состав: 65% полиэфир, 35% вискоза',
  ],
  image: '',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing evokSniperCloak = Clothing(
  name: 'Снайперская накидка «Эвок»',
  linkToStore: '',
  features: [
    'Маскировочная накидка с сеточной основой и нашитыми листьями',
    'Накидка маскирует верхнюю часть тела',
    'Состав: 65% полиэфир, 35% вискоза',
  ],
  image: '',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing pokrovSniperScarf = Clothing(
  name: 'Снайперский шарф «Покров»',
  linkToStore: '',
  features: [
    'Сетчатый шарф маскировочных цветов',
    'Отлично вентилируется и маскирует голову пользователя',
    'Состав: 100% полиэфир',
  ],
  image: '',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing scoutMaskCover = Clothing(
  name: 'Маскировочный чехол «Следопыт»',
  linkToStore: '',
  features: [
    'Маскировочный чехол с сеточной основой и нашитыми листьями',
    'Подходит для любого шлема',
    'Состав: 65% полиэфир, 35% вискоза',
  ],
  image: '',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing vorohMaskCover = Clothing(
  name: 'Маскировочный чехол «Ворох»',
  linkToStore: '',
  features: [
    'Маскировочный чехол с сеточной основой и нашитыми листьями',
    'Маскирует рюкзаки объемом до 45 литров',
    'Состав: 65% полиэфир, 35% вискоза',
  ],
  image: '',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

// ============================ sets ===========================================

Clothing scoutMaskingSet = Clothing(
  name: 'Маскировочный костюм "Скаут"',
  linkToStore:
  'https://mordor-tac.com/product/mordortac-summer-masking-suit-scout',
  features: [
    'Отлично скрывает силуэт человека в растительности',
    'Произведен из легкой, быстросохнущей ткани не сковывающей движение',
    'Состав: 65% полиэстер, 35% вискоза',
  ],
  image: 'assets/images/scout.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

Clothing gopTacSet = Clothing(
  name: 'Костюм "Гоп Так"',
  linkToStore:
  '',
  features: [
    'Тактический костюм из легкой сорочечной ткани',
    'Отлично подходит для страйкбольных мероприятий и поведневной носки',
    'Состав: 65% полиэстер, 35% вискоза',
  ],
  image: '',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
);

// ============================ hats ===========================================

Clothing nordHat = Clothing(
  name: 'Шапка флисовая "Норд"',
  linkToStore: 'https://mordor-tac.com/product/mordortac-fleece-hat-nord',
  features: [
    'Теплая шапка из флиса',
    'Отводит влагу от тела и согревает',
    'Может использоваться под шлемом',
    'Состав: 100% полиэстер',
  ],
  image: 'assets/images/nordHat.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Clothing windPanama = Clothing(
  name: 'Панама "Ветер"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-panama-veter',
  features: [
    'Летняя панама с дополнительной вентиляцией',
    'Высокопрочная дышащая ткань Рип стоп',
    'Универсальный размер',
    'Состав: 50% хлопок, 50% полиамид',
  ],
  image: 'assets/images/windPanama.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Clothing peasantUnderhelmet = Clothing(
  name: 'Шапка-подшлемник "Пизант"',
  linkToStore: 'https://mordor-tac.com/product/hat-liner-peasant',
  features: [
    'Теплая шапка из "Вафли"',
    'Отводит влагу от тела и согревает',
    'Идеально для использования под шлемом',
    'Состав: 98% полиэстер, 2% эластан',
  ],
  image: 'assets/images/peasantUnderhelmet.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Clothing gasBaseball = Clothing(
  name: 'Бейсболка "Гас"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-baseball-cap-gaz',
  features: [
    'Бейсболка из ткани плотного плетения',
    'Защищает от ветра и слабого дождя',
    'Велкро панели для патчей',
    'Состав: 50% хлопок, 50% полиамид',
  ],
  image: 'assets/images/gasBaseball.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Clothing neoBandana = Clothing(
  name: 'Бандана "Нео"',
  linkToStore: 'https://mordor-tac.com/product/mordortac-bandana-setka',
  features: [
    'Отводит влагу от тела',
    'Легкая бандана из эластичной ткани',
    'Состав: 97% полиэфир, 3% эластан',
  ],
  image: 'assets/images/neoBandana.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

// ============================ buff ===========================================

Clothing fjordBuff = Clothing(
  name: 'Зимний флисовый бафф "Фьорд"',
  linkToStore: 'https://mordor-tac.com/product/mordorta-buff-fjord',
  features: [
    'Теплый бафф из флиса',
    'Отводит влагу от тела и согревает',
    'Эластичная резинка держит бафф на лице',
    'Состав: 100% полиэстер',
  ],
  image: 'assets/images/fjordBuff.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Clothing dozorBuff = Clothing(
  name: 'Демисезонный бафф "Дозор"',
  linkToStore: 'https://mordor-tac.com/product/mordortacfleece-buff-dozor',
  features: [
    'Теплая балаклава из "Вафли"',
    'Отводит влагу от тела и согревает',
    'Эластичная ткань',
    'Состав: 98% полиэстер, 2% эластан',
  ],
  image: 'assets/images/dozorBuff.png',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Clothing raiderBuff = Clothing(
  name: 'Бафф "Рейдер"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-buff-raider',
  features: [
    'Отводит влагу от тела',
    'Легкая балаклава из эластичной ткани',
    'Состав: 97% полиэфир, 3% эластан',
  ],
  image: 'assets/images/raiderBuff.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

// ========================= balaclavas ========================================

Clothing vaderBalaclava = Clothing(
  name: 'Зимняя флисовая балаклава "Вейдер"',
  linkToStore:
  'https://mordor-tac.com/product/mordortac-winter-balaclava-vader',
  features: [
    'Теплая балаклава из флиса',
    'Отводит влагу от тела и согревает',
    'Имеется отверстие для дыхания',
    'Состав: 100% полиэстер',
  ],
  image: 'assets/images/vaderBalaclava.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Clothing koifBalavlava = Clothing(
  name: 'Балаклава "Койф"',
  linkToStore: 'https://mordor-tac.com/product/MordorTac-winter-balaclava-coif',
  features: [
    'Теплая балаклава из "Вафли"',
    'Отводит влагу от тела и согревает',
    'Эластичная ткань',
    'Состав: 98% полиэстер, 2% эластан',
  ],
  image: 'assets/images/koifBalaclava.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

Clothing ninjaBalaclava = Clothing(
  name: 'Балаклава "Ниндзя"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-balaclava-ninja',
  features: [
    'Отводит влагу от тела',
    'Легкая балаклава из эластичной ткани',
    'Состав: 97% полиэфир, 3% эластан',
  ],
  image: 'assets/images/ninjaBalaclava.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);

// ============================ gloves =========================================

Clothing dlanGloves = Clothing(
  name: 'Флисовые перчатки "Длань"',
  linkToStore: 'https://mordor-tac.com/product/fleece-gloves-dlan',
  features: [
    'Теплые перчатки из флиса',
    'Отводят влагу от тела и согревают',
    'Быстро сохнут при намокании',
    'Состав: 100% полиэстер',
  ],
  image: 'assets/images/dlanGloves.jpg',
  inSuitLayer: null,
  isNecessary: false,
  isHasAlready: false,
);









