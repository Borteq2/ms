import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mordor_suit/feature/widgets/_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Talker talker = GetIt.I<Talker>();
  AppStore appStore = GetIt.I<AppStore>();
  final PageController pageController = PageController(initialPage: 0);
  final PageController pageController2 = PageController(initialPage: 0);
  int currentPage = 0;
  int currentPage2 = 0;

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
        appBar: AppBar(
          title: TitleWidget(appStore: appStore),
        ),
        body: appStore.weatherStore.city.isEmpty
            ? LoadingWidget(appStore: appStore)
            : Column(
                children: [
                  Text('Комплект: ${appStore.suitStore.suit.name}'),
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
                              ? Center(
                                  // вертикальные бипки
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                            '${appStore.suitStore.resultMap.entries.elementAt(index).value[0].image}'),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${appStore.suitStore.resultMap.entries.elementAt(index).value[0].name}',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: GestureDetector(
                                            onTap: () => launchUrl(
                                              Uri.parse(
                                                appStore
                                                    .suitStore.resultMap.entries
                                                    .elementAt(index)
                                                    .value[0]
                                                    .linkToStore,
                                              ),
                                            ),
                                            child: Text(
                                              '${appStore.suitStore.resultMap.entries.elementAt(index).value[0].linkToStore}',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: appStore
                                                  .suitStore.resultMap.entries
                                                  .elementAt(index)
                                                  .value[0]
                                                  .features
                                                  .length,
                                              itemBuilder:
                                                  (context, featureIndex) =>
                                                      Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '● ${appStore.suitStore.resultMap.entries.elementAt(index).value[0].features[featureIndex]}',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Слой: ${index + 1}',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: Text(
                                            appStore.suitStore.resultMap.entries
                                                    .elementAt(index)
                                                    .value[0]
                                                    .isNecessary
                                                ? 'Рекомендуется'
                                                : 'По необходимости',
                                            style: TextStyle(
                                              color: appStore.suitStore
                                                      .resultMap.entries
                                                      .elementAt(currentPage)
                                                      .value[index]
                                                      .isNecessary
                                                  ? Colors.deepOrange
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                        itemBuilder: (context, index) => Center(
                                          // горизонтальные бипки
                                          // appStore.suitStore.resultMap.entries.elementAt(_currentPage).value[index]
                                          child: Card(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset(
                                                    '${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[index].image}'),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[index].name}',
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: GestureDetector(
                                                    onTap: () => launchUrl(
                                                      Uri.parse(
                                                        appStore.suitStore
                                                            .resultMap.entries
                                                            .elementAt(
                                                                currentPage)
                                                            .value[index]
                                                            .linkToStore,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      '${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[index].linkToStore}',
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: appStore
                                                          .suitStore
                                                          .resultMap
                                                          .entries
                                                          .elementAt(
                                                              currentPage)
                                                          .value[index]
                                                          .features
                                                          .length,
                                                      itemBuilder: (context,
                                                              featureIndex) =>
                                                          Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          '● ${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[index].features[featureIndex]}',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Слой: ${index + 1}',
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 16),
                                                  child: Text(
                                                    appStore.suitStore.resultMap
                                                            .entries
                                                            .elementAt(
                                                                currentPage)
                                                            .value[index]
                                                            .isNecessary
                                                        ? 'Рекомендуется'
                                                        : 'По необходимости',
                                                    style: TextStyle(
                                                      color: appStore.suitStore
                                                              .resultMap.entries
                                                              .elementAt(
                                                                  currentPage)
                                                              .value[index]
                                                              .isNecessary
                                                          ? Colors.deepOrange
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
            : FloatingActionButton(
                onPressed: () => appStore.suitStore.setSuitByTemperatureType(),
                tooltip: 'Что надеть?',
                child: const Icon(Icons.add),
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
