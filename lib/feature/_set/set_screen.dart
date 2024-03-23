import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mordor_suit/feature/_set/subfeatures/_item_card/_widgets.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:mordor_suit/feature/_set/widgets/_widgets.dart';

class SetScreen extends StatefulWidget {
  const SetScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SetScreen> createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {
  Talker talker = GetIt.I<Talker>();
  AppStore appStore = GetIt.I<AppStore>();

  int currentPageVertical = 0;
  int currentPageHorizontal = 0;

  final PageController pageControllerVertical = PageController(initialPage: 0);
  final PageController pageControllerHorizontal =
      PageController(initialPage: 0);

  void resetHorizontalPage() => setState(() {
        currentPageHorizontal = 0;
        pageControllerHorizontal.jumpToPage(0);
      });

  @override
  void initState() {
    super.initState();
    if (kReleaseMode) {
      AppMetrica.reportEventWithMap(
        'Открыт экран комплекта',
        {
          'Комплект': appStore.suitStore.suit.name,
        },
      );
    }
    appStore.clothingMemoryStore.syncHasAlreadyListsWithBoxes();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WeatherPreset weather = GoRouterState.of(context).extra! as WeatherPreset;
    appStore.presetWeatherStore.setSuitByWeatherManually(weather);
    appStore.suitStore.setSuitByTemperatureType();
    talker.info(appStore.presetWeatherStore.weatherDataMap);
  }

  @override
  void dispose() {
    pageControllerVertical.dispose();
    pageControllerHorizontal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => PopScope(
        canPop: true,
        onPopInvoked: (_) {
          if (kReleaseMode) {
            AppMetrica.reportEventWithMap(
              'Нажата кнопка "назад" на телефоне',
              {
                'С экрана': 'Комплект',
                'На экран': 'Дашборд с пресетами',
              },
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                if (kReleaseMode) {
                  AppMetrica.reportEventWithMap(
                    'Нажата кнопка-стрелка "назад" в приложении (appBar)',
                    {
                      'С экрана': 'Комплект',
                      'На экран': 'Дашборд с пресетами',
                    },
                  );
                }
                context.pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(
              'Комплект: ${appStore.suitStore.suit.name}, ${appStore.presetWeatherStore.city}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          body: Row(
            children: [
              VerticalDotsWidget(
                context: context,
                suitStore: appStore.suitStore,
                currentPage: currentPageVertical,
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PageView(
                    controller: pageControllerVertical,
                    scrollDirection: Axis.vertical,
                    pageSnapping: true,
                    children: [
                      ...List.generate(
                        appStore.suitStore.layersWithItemsCount,
                        (index) => Column(
                          children: [
                            Expanded(
                              child: PageView(
                                controller: pageControllerHorizontal,
                                scrollDirection: Axis.horizontal,
                                pageSnapping: true,
                                onPageChanged: (int page) => setState(() {
                                  currentPageHorizontal = page;
                                }),
                                children: [
                                  ...appStore
                                      .suitStore.itemsListByLayerList[index]
                                      .map(
                                    (e) => ItemCardWidget(
                                      appStore: appStore,
                                      currentItem: e,
                                      index: currentPageVertical,
                                      onHaveAlreadyBtnTap: () =>
                                          resetHorizontalPage(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            HorizontalDotsWidget(
                              context: context,
                              suitStore: appStore.suitStore,
                              currentPage2: currentPageHorizontal,
                              index: index,
                            )
                          ],
                        ),
                      )
                    ],
                    onPageChanged: (int page) {
                      setState(() {
                        currentPageVertical = page;
                        currentPageHorizontal = 0;
                      });
                      try {
                        pageControllerHorizontal.jumpToPage(0);
                      } catch (e) {
                        talker.debug('Скроллконтроллер недоволен');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
