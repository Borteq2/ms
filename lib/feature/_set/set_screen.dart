import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mordor_suit/feature/_dashboard/widgets/_widgets.dart';
import 'package:mordor_suit/feature/library/config/sizes.dart';
import 'package:mordor_suit/feature/library/widgets/_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';

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

  @override
  void initState() {
    super.initState();
    if (kReleaseMode) {
      AppMetrica.reportEvent('Открыт экран комплекта');
    }
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
    return Observer(
      builder: (_) => PopScope(
        canPop: true,
        onPopInvoked: (_) {
          if (kReleaseMode) {
            AppMetrica.reportEvent('Нажата кнопка "назад" на телефоне');
          }
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                if (kReleaseMode) {
                  AppMetrica.reportEvent(
                      'Нажата кнопка-стрелка "назад" в приложении');
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
                  height: SizesConfig(context).clothingCardHeight,
                  width: SizesConfig(context).clothingCardWidth,
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
                        ? VerticalCardWidget(
                            appStore: appStore,
                            currentPage: currentPage,
                            index: index,
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
                                      HorizontalCardWidget(
                                    appStore: appStore,
                                    currentPage: currentPage,
                                    index: index,
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
