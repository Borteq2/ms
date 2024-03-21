import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/feature/_set/subfeatures/_subfeatures_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';
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

  int currentPage = 0;
  int currentPage2 = 0;

  final PageController pageController = PageController(initialPage: 0);
  final PageController pageController2 = PageController(initialPage: 0);

  void resetHorizontalPage() => setState(() {
        currentPage2 = 0;
        pageController2.jumpToPage(0);
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

    // TODO: дорефачить
    WeatherPreset weather = GoRouterState.of(context).extra! as WeatherPreset;
    appStore.presetWeatherStore.setSuitByWeatherManually(weather);
    appStore.suitStore.setSuitByTemperatureType();
    talker.info(appStore.presetWeatherStore.weatherDataMap);
  }

  @override
  void dispose() {
    pageController.dispose();
    pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // talker.info(appStore.suitStore.resultMap);
    // talker.info(appStore.suitStore.resultMap.entries.elementAt(1));
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
                currentPage: currentPage,
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.vertical,
                    pageSnapping: true,
                    itemCount: appStore.suitStore.layersWithItemsCount,
                    itemBuilder: (context, index) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: pageController2,
                                  itemCount: appStore
                                      .suitStore.resultMap.entries
                                      .elementAt(index)
                                      .value
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  pageSnapping: true,
                                  itemBuilder: (context, index) =>
                                      ItemCardWidget(
                                    appStore: appStore,
                                    currentPage: currentPage,
                                    index: index,
                                    type: CardType.horizontal,
                                    onHaveAlreadyBtnTap: resetHorizontalPage,
                                  ),
                                  onPageChanged: (int page) {
                                    setState(() => currentPage2 = page);
                                  },
                                ),
                              ),
                              HorizontalDotsWidget(
                                context: context,
                                suitStore: appStore.suitStore,
                                currentPage2: currentPage2,
                                index: index,
                              ),
                            ],
                          ),
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                        currentPage2 = 0;
                      });
                      try {
                        pageController2.jumpToPage(0);
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
