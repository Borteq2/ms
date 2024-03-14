import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/feature/_dashboard/widgets/_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';

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

    Map<String, dynamic> weather =
        GoRouterState.of(context).extra! as Map<String, dynamic>;
    appStore.currentWeatherStore.setSuitByWeatherManually(weather);
    appStore.suitStore.setSuitByTemperatureType();
    talker.warning(appStore.currentWeatherStore.weatherDataMap);
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
              'Комплект: ${appStore.suitStore.suit.name}, ${appStore.currentWeatherStore.city}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          body: Row(
            children: [
              appStore.suitStore.layersWithItemsCount > 0
                  ? DotsIndicator(
                      dotsCount: appStore.suitStore.layersWithItemsCount,
                      position: currentPage.toInt(),
                      axis: Axis.vertical,
                      decorator: DotsDecorator(
                        color: Theme.of(context).disabledColor,
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.vertical,
                    pageSnapping: true,
                    itemCount: appStore.suitStore.layersWithItemsCount,
                    itemBuilder: (context, index) => appStore
                                .suitStore.resultMap.entries
                                .elementAt(index)
                                .value
                                .length ==
                            1
                        ? ItemCardWidget(
                            appStore: appStore,
                            currentPage: currentPage,
                            index: index,
                            type: CardType.vertical,
                            onHaveAlreadyBtnTap: resetHorizontalPage,
                          )
                        : Column(
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
                              appStore.suitStore.resultMap.entries
                                      .elementAt(index)
                                      .value
                                      .isNotEmpty
                                  ? DotsIndicator(
                                      dotsCount: appStore
                                          .suitStore.resultMap.entries
                                          .elementAt(index)
                                          .value
                                          .length,
                                      position: currentPage2.toInt(),
                                      axis: Axis.horizontal,
                                      decorator: DotsDecorator(
                                        color: Theme.of(context).disabledColor,
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                        currentPage2 = 0;
                      });
                      try {
                        pageController2.jumpToPage(0);
                      } catch (e, st) {
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
