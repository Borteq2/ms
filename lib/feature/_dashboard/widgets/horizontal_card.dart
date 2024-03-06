import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:url_launcher/url_launcher.dart';

class HorizontalCardWidget extends StatelessWidget {
  const HorizontalCardWidget({
    super.key,
    required this.appStore,
    required this.currentPage,
    required this.index,
  });

  final AppStore appStore;
  final int currentPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ImageWidget(
                appStore: appStore, currentPage: currentPage, index: index),
            _NameWidget(
                appStore: appStore, currentPage: currentPage, index: index),
            _LinkWidget(
                appStore: appStore, currentPage: currentPage, index: index),
            _FeaturesListWidget(
                appStore: appStore, currentPage: currentPage, index: index),
            _LayerWidget(
                appStore: appStore, currentPage: currentPage, index: index),
            _NecessaryWidget(
                appStore: appStore, currentPage: currentPage, index: index),
          ],
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.appStore,
    required this.currentPage,
    required this.index,
  });

  final AppStore appStore;
  final int currentPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
          '${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[index].image}'),
    );
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    required this.appStore,
    required this.currentPage,
    required this.index,
  });

  final AppStore appStore;
  final int currentPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[index].name}',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class _LinkWidget extends StatelessWidget {
  const _LinkWidget({
    required this.appStore,
    required this.currentPage,
    required this.index,
  });

  final AppStore appStore;
  final int currentPage;
  final int index;

  // launchUrl(
  // Uri.parse(
  // appStore.suitStore.resultMap.entries
  //     .elementAt(currentPage)
  //     .value[index]
  //     .linkToStore,
  // ),
  // )

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.black.withOpacity(0.9),
            surfaceTintColor: Colors.black,
            title: const Text(
              'Где купить?',
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      launchUrl(
                        Uri.parse(
                          appStore.suitStore.resultMap.entries
                              .elementAt(currentPage)
                              .value[index]
                              .linkToStore,
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/favicon.svg',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 20),
                        const Text('Интернет-магазин'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Нет ссылки'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/wb.svg',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 20),
                        const Text('Wildberries'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Нет ссылки'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/ozon.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 20),
                        const Text('Ozon'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Нет ссылки'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.man,
                          size: 40,
                        ),
                        SizedBox(width: 20),
                        Text('Шоурум'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Отмена'),
              ),
            ],
          ),
        ),
        child: RichText(
          text: const TextSpan(
            text: 'ПРИОБРЕСТИ',
            style: TextStyle(
                color: Colors.deepOrange, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _FeaturesListWidget extends StatelessWidget {
  const _FeaturesListWidget({
    required this.appStore,
    required this.currentPage,
    required this.index,
  });

  final AppStore appStore;
  final int currentPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: appStore.suitStore.resultMap.entries
              .elementAt(currentPage)
              .value[index]
              .features
              .length,
          itemBuilder: (context, featureIndex) => Text(
            '● ${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[index].features[featureIndex]}',
          ),
        ),
      ),
    );
  }
}

class _LayerWidget extends StatelessWidget {
  const _LayerWidget({
    required this.appStore,
    required this.currentPage,
    required this.index,
  });

  final AppStore appStore;
  final int currentPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return appStore.suitStore.resultMap.entries
                .elementAt(currentPage)
                .value[index]
                .inSuitLayer !=
            null
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Слой: ${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[index].inSuitLayer}',
              style: const TextStyle(fontSize: 20),
            ),
          )
        : const SizedBox.shrink();
  }
}

class _NecessaryWidget extends StatelessWidget {
  const _NecessaryWidget({
    required this.appStore,
    required this.currentPage,
    required this.index,
  });

  final AppStore appStore;
  final int currentPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        appStore.suitStore.resultMap.entries
                .elementAt(currentPage)
                .value[index]
                .isNecessary
            ? 'Рекомендуется'
            : 'По необходимости',
        style: TextStyle(
          color: appStore.suitStore.resultMap.entries
                  .elementAt(currentPage)
                  .value[index]
                  .isNecessary
              ? Colors.deepOrange
              : Colors.grey,
        ),
      ),
    );
  }
}
