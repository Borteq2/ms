import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mordor_suit/feature/widgets/_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dots_indicator/dots_indicator.dart';

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
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _pageController2 = PageController(initialPage: 0);
  int _currentPage = 0;
  int _currentPage2 = 0;

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
          surfaceTintColor: Colors.transparent,
          title: TitleWidget(appStore: appStore),
        ),
        body: appStore.weatherStore.city.isEmpty
            ? LoadingWidget(appStore: appStore)
            : Row(
                children: [
                  appStore.suitStore.layersWithItemsCount > 0
                      ? DotsIndicator(
                          dotsCount: appStore.suitStore.layersWithItemsCount,
                          position: _currentPage.toInt(),
                          axis: Axis.vertical,
                          decorator: const DotsDecorator(
                            color: Colors.grey,
                            activeColor: Colors.deepOrange,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: PageView.builder(
                        controller: _pageController,
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
                                child: Text(
                                    '${appStore.suitStore.resultMap.entries.elementAt(index).value[0]}'
                                    // '${appStore.suitStore.resultMap.entries.elementAt(index).value[0].name}'
                                    ),
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: PageView.builder(
                                      controller: _pageController2,
                                      itemCount: appStore
                                          .suitStore.resultMap.entries
                                          .elementAt(index)
                                          .value
                                          .length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => Center(
                                        // горизонтальные бипки
                                        child: Text(
                                            '${appStore.suitStore.resultMap.entries.elementAt(_currentPage).value[index]}'),
                                      ),
                                      onPageChanged: (int page) {
                                        setState(() => _currentPage2 = page);
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
                                          position: _currentPage2.toInt(),
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
                          setState(() => _currentPage = page);
                        },
                      ),
                    ),
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
    _pageController.dispose();
    _pageController2.dispose();
    super.dispose();
  }
}
