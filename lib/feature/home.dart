import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:mordor_suit/feature/widgets/_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Talker talker = GetIt.I<Talker>();
  AppStore appStore = GetIt.I<AppStore>();

  int currentPage = 0;
  int currentPage2 = 0;

  final PageController pageController = PageController(initialPage: 0);
  final PageController pageController2 = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    appStore.weatherStore.geoPermission = true;
    appStore.weatherStore.getLocationAndWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(title: TitleWidget(appStore: appStore)),
        body: appStore.weatherStore.isWeatherLoaded
            ? LoadingWidget(appStore: appStore)
            : Column(
                children: [
                  appStore.suitStore.suit.name != 'Нет подходящего'
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Комплект: ${appStore.suitStore.suit.name}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Row(
                    children: [
                      appStore.suitStore.layersWithItemsCount > 0
                          ? DotsIndicator(
                              dotsCount:
                                  appStore.suitStore.layersWithItemsCount,
                              position: currentPage.toInt(),
                              axis: Axis.vertical,
                              decorator: const DotsDecorator(
                                color: Colors.grey,
                                activeColor: Colors.deepOrange,
                              ),
                            )
                          : const SizedBox.shrink(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: PageView.builder(
                          controller: pageController,
                          scrollDirection: Axis.vertical,
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
                                            decorator: const DotsDecorator(
                                              color: Colors.grey,
                                              activeColor: Colors.deepOrange,
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
                            pageController2.jumpToPage(0);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        floatingActionButton: appStore.weatherStore.city.toString().isEmpty ||
                appStore.suitStore.layersWithItemsCount > 0
            ? const SizedBox.shrink()
            : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.deepOrange,
                    width: 2,
                  ),
                ),
                child: FloatingActionButton(
                  onPressed: () =>
                      appStore.suitStore.setSuitByTemperatureType(),
                  tooltip: 'Как экипироваться по погоде?',
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset(
                    'assets/images/favicon.svg',
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    pageController2.dispose();
    super.dispose();
  }
}
