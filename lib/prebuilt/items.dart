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
  linkToWb: null,
  linkToOzon: null,
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158417838/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/komplekt-termobelya-mordor-tac-815934423/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158745592/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/komplekt-termobelya-mordor-tac-840581188/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/196657428/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/futbolka-mordor-tac-1-sht-1342984776/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158362200/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/longsliv-mordor-tac-805917493/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/168935555/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/kurtka-flisovaya-cheburashka-1077579966/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/155808472/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/tolstovka-ural-525947655/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/155800365/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/boevaya-rubashka-saratov-nyco-oliva-od-52-54-170-176-525942483/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158369720/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/demisezonnaya-boevaya-kurtka-volk-912528762/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/155806730/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/letnie-bryuki-saratov-multikam-44-46-158-164-570619576/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/155825955/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/demisezonnye-bryuki-volk-tsifrovaya-flora-emr-48-50-170-176-881358356/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/211641589/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/bryuki-mordor-tac-1431703088/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158751459/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/bryuki-uteplennye-mordor-tac-1365215909/',
);

Clothing freelancerShorts = Clothing(
  name: 'Шорты "Фрилансер"',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-shorts-freelancer',
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
  linkToWb: null,
  linkToOzon: null,
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
  linkToWb:
      'https://www.wildberries.ru/catalog/182817009/detail.aspx?targetUrl=GP',
  linkToOzon: null,
);

Clothing snowmanMaskSuit = Clothing(
  name: 'Маскировочный костюм «Снеговик»',
  linkToStore: 'https://mordor-tac.com/product/winter-camouflage-suit-snegovik',
  features: [
    'Ткань не замерзает и не шуршит',
    'Костюм состоящий из брюк, куртки, жилета и мешка',
    'Состав: 100% полиэстер',
  ],
  image: 'assets/images/snowmanMaskSuit.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
  linkToWb:
      'https://www.wildberries.ru/catalog/193026658/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/zimniy-maskirovochnyy-kostyum-snegovik-1319273526/',
);

Clothing sugrobBackpackCover = Clothing(
  name: 'Чехол для рюкзака «Сугроб»',
  linkToStore:
      'https://mordor-tac.com/product/winter-camouflage-backpack-cover-sugrob',
  features: [
    'Ткань не замерзает и не шуршит',
    'Чехол для рюкзака объемом до 45 литров',
    'Состав: 100% полиэстер',
  ],
  image: 'assets/images/sugrobBackpackCover.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
  linkToWb:
      'https://www.wildberries.ru/catalog/193026409/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/zimniy-maskirovochnyy-chehol-dlya-ryukzaka-sugrob-1319278211/',
);

Clothing snowballHelmetCover = Clothing(
  name: 'Чехол для шлема «Снежок»',
  linkToStore:
      'https://mordor-tac.com/product/winter-camouflage-helmet-cover-snezhok',
  features: [
    'Ткань не замерзает и не шуршит',
    'Подходит для любого шлема',
    'Состав: 100% полиэстер',
  ],
  image: 'assets/images/snowballHelmetCover.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
  linkToWb:
      'https://www.wildberries.ru/catalog/193027092/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/search/?deny_category_prediction=true&from_global=true&text=%D0%A7%D0%B5%D1%85%D0%BE%D0%BB+%D0%B4%D0%BB%D1%8F+%D1%88%D0%BB%D0%B5%D0%BC%D0%B0&product_id=1319279775',
);

Clothing frakSniperCloak = Clothing(
  name: 'Снайперская накидка «Фрак»',
  linkToStore: 'https://mordor-tac.com/product/sniper-coat-frak-big',
  features: [
    'Маскировочная накидка с сеточной основой и нашитыми листьями',
    'Полноразмерная накидка, маскирующая ростовую фигуру',
    'Состав: 65% полиэфир, 35% вискоза',
  ],
  image: 'assets/images/frakSniperCloak.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
  linkToWb:
      'https://www.wildberries.ru/catalog/168937316/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/maskirovochnaya-setka-snayperskaya-nakidka-frak-bolshaya-1077841166/',
);

Clothing evokSniperCloak = Clothing(
  name: 'Снайперская накидка «Эвок»',
  linkToStore: 'https://mordor-tac.com/product/mordor-tac-sniper-coat-ewok',
  features: [
    'Маскировочная накидка с сеточной основой и нашитыми листьями',
    'Накидка маскирует верхнюю часть тела',
    'Состав: 65% полиэфир, 35% вискоза',
  ],
  image: 'assets/images/evokSniperCloak.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
  linkToWb:
      'https://www.wildberries.ru/catalog/158416721/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/snayperskaya-nakidka-evok-multikam-644371393/',
);

Clothing pokrovSniperScarf = Clothing(
  name: 'Снайперский шарф «Покров»',
  linkToStore:
      'https://mordor-tac.com/product/universal-camouflage-cape-pokrov',
  features: [
    'Сетчатый шарф маскировочных цветов',
    'Отлично вентилируется и маскирует голову пользователя',
    'Состав: 100% полиэфир',
  ],
  image: 'assets/images/pokrovSniperScarf.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
  linkToWb:
      'https://www.wildberries.ru/catalog/166278525/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/snayperskiy-sharf-pokrov-1046129997/',
);

Clothing scoutMaskCover = Clothing(
  name: 'Маскировочный чехол «Следопыт»',
  linkToStore:
      'https://mordor-tac.com/product/universal-masking-cover-sledopit',
  features: [
    'Маскировочный чехол с сеточной основой и нашитыми листьями',
    'Подходит для любого шлема',
    'Состав: 65% полиэфир, 35% вискоза',
  ],
  image: 'assets/images/scoutMaskCover.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
  linkToWb:
      'https://www.wildberries.ru/catalog/156779023/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/universalnyy-maskirovochnyy-chehol-sledopyt-890941990/',
);

Clothing vorohMaskCover = Clothing(
  name: 'Маскировочный чехол «Ворох»',
  linkToStore:
      'https://mordor-tac.com/product/camouflage-cover-for-backpack-voroh',
  features: [
    'Маскировочный чехол с сеточной основой и нашитыми листьями',
    'Маскирует рюкзаки объемом до 45 литров',
    'Состав: 65% полиэфир, 35% вискоза',
  ],
  image: 'assets/images/vorohMaskCover.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
  linkToWb:
      'https://www.wildberries.ru/catalog/167633684/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/maskirovochnyy-chehol-na-ryukzak-voroh-1061274037/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/155822956/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/maskirovochnyy-kostyum-skaut-tsifrovaya-flora-emr-56-58-170-176-525941884/',
);

Clothing gopTacSet = Clothing(
  name: 'Костюм "Гоп Так"',
  linkToStore: 'https://mordor-tac.com/product/mordortac-gop-tac-suit',
  features: [
    'Тактический костюм из легкой сорочечной ткани',
    'Отлично подходит для страйкбольных мероприятий и поведневной носки',
    'Состав: 65% полиэстер, 35% вискоза',
  ],
  image: 'assets/images/gopTacSet.jpg',
  inSuitLayer: null,
  isNecessary: true,
  isHasAlready: false,
  linkToWb:
      'https://www.wildberries.ru/catalog/155870976/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/takticheskiy-kostyum-gop-tak-koyot-braun-52-54-182-188-1454472922/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158979278/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/shapka-mordor-tac-1398026284/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158936608/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/panama-mordor-tac-672733401/',
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
  linkToWb: null,
  linkToOzon: null,
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
  linkToWb:
      'https://www.wildberries.ru/catalog/216739051/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/search/?deny_category_prediction=true&from_global=true&text=%D0%91%D0%B5%D0%B9%D1%81%D0%B1%D0%BE%D0%BB%D0%BA%D0%B0&product_id=531320546',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/164798283/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/bandana-dlya-rybalki-i-ohoty-mordor-tac-1025347862/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/174983822/detail.aspx?targetUrl=GP',
  linkToOzon:
      'https://www.ozon.ru/product/zimniy-flisovyy-baff-ford-1400485314/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158930168/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/baff-demisezonnyy-dozor-840555470/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158344515/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/baff-reyder-chernyy-629291353/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/200696350/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/balaklava-mordor-tac-1160216676/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158927711/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/balaklava-mordor-tac-825402771/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/158344415/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/balaklava-mordor-tac-629498341/',
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
  linkToWb:
      'https://www.wildberries.ru/catalog/197283776/detail.aspx?targetUrl=GP',
  linkToOzon: 'https://www.ozon.ru/product/perchatki-mordor-tac-1350864392/',
);
