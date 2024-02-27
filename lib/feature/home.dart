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
                  appStore.suitStore.equipCount > 0
                      ? DotsIndicator(
                          dotsCount: appStore.suitStore.equipCount -
                              appStore.suitStore.suitAccessoriesList.length +
                              1,
                          position: _currentPage.toInt(),
                          axis: Axis.vertical,
                          decorator: const DotsDecorator(
                            color: Colors.grey,
                            activeColor: Colors.deepOrange,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      itemCount: appStore.suitStore.equipCount -
                          appStore.suitStore.suitAccessoriesList.length +
                          1,
                      itemBuilder: (context, index) => index <
                              (appStore.suitStore.equipCount -
                                  appStore.suitStore.suitAccessoriesList.length)
                          ? Center(
                              child: Text(
                                appStore.suitStore.equipList[index].name,
                              ),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: PageView.builder(
                                    controller: _pageController2,
                                    itemCount: appStore
                                        .suitStore.suitAccessoriesList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Center(
                                      child: Text(
                                        appStore.suitStore
                                            .suitAccessoriesList[index].name,
                                      ),
                                    ),
                                    onPageChanged: (int page) {
                                      setState(() => _currentPage2 = page);
                                    },
                                  ),
                                ),
                                appStore.suitStore.suitAccessoriesList
                                        .isNotEmpty
                                    ? DotsIndicator(
                                        dotsCount: appStore.suitStore
                                            .suitAccessoriesList.length,
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
                ],
              ),
        floatingActionButton: appStore.weatherStore.city.toString().isEmpty ||
                appStore.suitStore.equipCount > 0
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
