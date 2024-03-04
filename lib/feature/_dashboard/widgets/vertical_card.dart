import 'package:flutter/material.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:url_launcher/url_launcher.dart';

class VerticalCardWidget extends StatelessWidget {
  const VerticalCardWidget({
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
            _ImageWidget(appStore: appStore, index: index),
            _NameWidget(appStore: appStore, index: index),
            _LinkWidget(appStore: appStore, index: index),
            _FeaturesListWidget(appStore: appStore, index: index),
            _LayerWidget(
                appStore: appStore, index: index, currentPage: currentPage),
            _NecessaryWidget(
                appStore: appStore, index: index, currentPage: currentPage),
          ],
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.appStore,
    required this.index,
  });

  final AppStore appStore;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        '${appStore.suitStore.resultMap.entries.elementAt(index).value[0].image}',
      ),
    );
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    required this.appStore,
    required this.index,
  });

  final AppStore appStore;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${appStore.suitStore.resultMap.entries.elementAt(index).value[0].name}',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class _LinkWidget extends StatelessWidget {
  const _LinkWidget({
    required this.appStore,
    required this.index,
  });

  final AppStore appStore;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(
            appStore.suitStore.resultMap.entries
                .elementAt(index)
                .value[0]
                .linkToStore,
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
    required this.index,
  });

  final AppStore appStore;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: appStore.suitStore.resultMap.entries
              .elementAt(index)
              .value[0]
              .features
              .length,
          itemBuilder: (context, featureIndex) => Text(
            '● ${appStore.suitStore.resultMap.entries.elementAt(index).value[0].features[featureIndex]}',
          ),
        ),
      ),
    );
  }
}

class _LayerWidget extends StatelessWidget {
  const _LayerWidget({
    required this.appStore,
    required this.index,
    required this.currentPage,
  });

  final AppStore appStore;
  final int index;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: appStore.suitStore.resultMap.entries
                  .elementAt(currentPage)
                  .value[0]
                  .inSuitLayer !=
              null
          ? Text(
              'Слой: ${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[0].inSuitLayer}',
              style: const TextStyle(fontSize: 20),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _NecessaryWidget extends StatelessWidget {
  const _NecessaryWidget({
    required this.appStore,
    required this.index,
    required this.currentPage,
  });

  final AppStore appStore;
  final int index;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        appStore.suitStore.resultMap.entries
                .elementAt(index)
                .value[0]
                .isNecessary
            ? 'Рекомендуется'
            : 'По необходимости',
        style: TextStyle(
          color: appStore.suitStore.resultMap.entries
                  .elementAt(currentPage)
                  .value[0]
                  .isNecessary
              ? Colors.deepOrange
              : Colors.grey,
        ),
      ),
    );
  }
}
