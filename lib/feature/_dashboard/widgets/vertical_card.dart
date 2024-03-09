import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
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
            _IsHasAlreadyWidget(appStore: appStore, index: index),
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: AutoSizeText(
        '${appStore.suitStore.resultMap.entries.elementAt(index).value[0].name}',
        style: const TextStyle(fontSize: 18),
        maxLines: 1,
      ),
    );
  }
}

// TODO: сомнительно, но окей
class _IsHasAlreadyWidget extends StatefulWidget {
  const _IsHasAlreadyWidget({
    required this.appStore,
    required this.index,
  });

  final AppStore appStore;
  final int index;

  @override
  State<_IsHasAlreadyWidget> createState() => _IsHasAlreadyWidgetState();
}

class _IsHasAlreadyWidgetState extends State<_IsHasAlreadyWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (newValue) {
            setState(
              () {
                isChecked = newValue ?? false;
                appStore.suitStore.resultMap.entries
                        .elementAt(widget.index)
                        .value[0]
                        .isHasAlready =
                    !appStore.suitStore.resultMap.entries
                        .elementAt(widget.index)
                        .value[0]
                        .isHasAlready;
              },
            );
          },
        ),
        Text(
          'Уже есть',
          style: TextStyle(
            color: appStore.suitStore.resultMap.entries
                    .elementAt(widget.index)
                    .value[0]
                    .isHasAlready
                ? Colors.deepOrange
                : Colors.white,
          ),
        )
      ],
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
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.8),
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
                                .elementAt(index)
                                .value[0]
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
        padding: const EdgeInsets.all(16.0),
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
      padding: const EdgeInsets.all(16.0),
      child: appStore.suitStore.resultMap.entries
                  .elementAt(currentPage)
                  .value[0]
                  .inSuitLayer !=
              null
          ? AutoSizeText(
              'Слой: ${appStore.suitStore.resultMap.entries.elementAt(currentPage).value[0].inSuitLayer}',
              style: const TextStyle(fontSize: 20),
              maxLines: 1,
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
