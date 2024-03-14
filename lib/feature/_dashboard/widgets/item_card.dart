import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:mordor_suit/feature/library/config/sizes.dart';
import 'package:mordor_suit/feature/library/enums.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

enum CardType { vertical, horizontal }

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.appStore,
    required this.index,
    required this.currentPage,
    required this.type,
    required this.onHaveAlreadyBtnTap,
  });

  final AppStore appStore;
  final int index;
  final int currentPage;
  final CardType type;
  final VoidCallback onHaveAlreadyBtnTap;

  @override
  Widget build(BuildContext context) {
    dynamic currentItem;

    switch (type) {
      case CardType.vertical:
        currentItem =
            appStore.suitStore.resultMap.entries.elementAt(index).value[0];
      case CardType.horizontal:
        currentItem = appStore.suitStore.resultMap.entries
            .elementAt(currentPage)
            .value[index];
    }

    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: GetIt.I<SizesConfig>().isKeyboardOpen ? 1 : 0,
                  child: _ImageWidget(item: currentItem)),
              _NameWidget(item: currentItem),
              _LinkWidget(
                appStore: appStore,
                item: currentItem,
                onHaveAlreadyBtnTap: onHaveAlreadyBtnTap,
              ),
              _FeaturesListWidget(item: currentItem),
              _LayerWidget(item: currentItem),
              _NecessaryWidget(item: currentItem, index: index),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset('${item.image}'),
    );
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: AutoSizeText(
        '${item.name}',
        style: const TextStyle(fontSize: 18),
        maxLines: 1,
      ),
    );
  }
}

class _LinkWidget extends StatefulWidget {
  const _LinkWidget({
    required this.item,
    required this.appStore,
    required this.onHaveAlreadyBtnTap,
  });

  final AppStore appStore;
  final VoidCallback onHaveAlreadyBtnTap;
  final item;

  @override
  State<_LinkWidget> createState() => _LinkWidgetState();
}

class _LinkWidgetState extends State<_LinkWidget> {
  void _preloadBoxData() async {
    await appStore.clothingMemoryStore.syncHasAlreadyListsWithBoxes();
    if (kReleaseMode) {
      AppMetrica.reportEventWithMap(
        'Синхронизация наличия с кэшем',
        {
          'Товар': '${widget.item.name}',
        },
      );
    }
  }

  @override
  void initState() {
    _preloadBoxData();
    super.initState();
  }

  void openLink(BuildContext context, LinkType linkType) async {
    switch (linkType) {
      case LinkType.mordor:
        AppMetrica.reportEventWithMap(
          'Переход на сайт Мордор',
          {
            'Переход': '${widget.item.name} -> ${widget.item.linkToStore}',
          },
        );
        Navigator.of(context).pop();
        launchUrl(
          Uri.parse(
            widget.item.linkToStore,
          ),
        );
      case LinkType.wb:
        AppMetrica.reportEventWithMap(
          'Переход на Wildberries',
          {
            'Переход': '${widget.item.name} -> ${widget.item.linkToStore}',
          },
        );
        Navigator.of(context).pop();
        launchUrl(
          Uri.parse(
            widget.item.linkToWb,
          ),
        );
      case LinkType.ozon:
        AppMetrica.reportEventWithMap(
          'Переход на Ozon',
          {
            'Переход': '${widget.item.name} -> ${widget.item.linkToStore}',
          },
        );
        Navigator.of(context).pop();
        launchUrl(
          Uri.parse(
            widget.item.linkToOzon,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Talker talker = GetIt.I<Talker>();

    bool isChecked;

    talker.info('Это шмотка, проверяю чекнутость');
    isChecked =
        appStore.clothingMemoryStore.boxedClothingList.contains(widget.item);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isChecked
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank_outlined,
            color: isChecked ? Colors.deepOrange : Colors.white,
          ),
          const SizedBox(width: 10),
          InkWell(
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
                      widget.item.linkToStore != null
                          ? TextButton(
                              onPressed: () {
                                openLink(context, LinkType.mordor);
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/favicon.svg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 20),
                                  const Text('Фирменный магазин'),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      widget.item.linkToWb != null
                          ? TextButton(
                              onPressed: () {
                                openLink(context, LinkType.wb);
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
                            )
                          : const SizedBox.shrink(),
                      widget.item.linkToOzon != null
                          ? TextButton(
                              onPressed: () {
                                openLink(context, LinkType.ozon);
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
                            )
                          : const SizedBox.shrink(),
                      TextButton(
                        onPressed: () async {
                          if (kReleaseMode) {
                            AppMetrica.reportEventWithMap(
                              'Построение маршрута в шоурум',
                              {
                                'Переход':
                                    '${widget.item.name} -> Маршрут навигатора в шоурум',
                              },
                            );
                          }
                          Navigator.of(context).pop();
                          await launchUrl(
                            Uri.parse(
                              'https://yandex.ru/maps/'
                              '?ll=${widget.appStore.localWeatherStore.currentPosition.latitude}'
                              '%2C${widget.appStore.localWeatherStore.currentPosition.longitude}'
                              '&mode=routes'
                              '&rtext=${widget.appStore.localWeatherStore.currentPosition.latitude}'
                              '%2C${widget.appStore.localWeatherStore.currentPosition.longitude}~55.665346%2C37.641111',
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
                  Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () async {
                              if (isChecked) {
                                await appStore.clothingMemoryStore
                                    .removeClothingFromBox(widget.item);
                                if (kReleaseMode) {
                                  AppMetrica.reportEventWithMap(
                                    'Изменение наличия',
                                    {
                                      'Было': 'Есть',
                                      'Стало': 'Нет',
                                    },
                                  );
                                }
                              } else {
                                await appStore.clothingMemoryStore
                                    .setClothingToBox(widget.item);
                                if (kReleaseMode) {
                                  AppMetrica.reportEventWithMap(
                                    'Изменение наличия',
                                    {
                                      'Было': 'Нет',
                                      'Стало': 'Есть',
                                    },
                                  );
                                }
                              }
                              widget.onHaveAlreadyBtnTap();
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text(isChecked ? 'Продал' : 'Уже есть'),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () async {
                              await GetIt.I<SizesConfig>()
                                  .disableKeyboardFlag();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Отмена'),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          if (kReleaseMode) {
                            AppMetrica.reportEventWithMap(
                              'Открыто меню калькулятора размеров',
                              {
                                'Кнопка': 'Как выбрать размер/рост?',
                              },
                            );
                          }
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.black.withOpacity(0.9),
                                surfaceTintColor: Colors.black,
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            if (kReleaseMode) {
                                              AppMetrica.reportEventWithMap(
                                                'Выбран режим калькуляции размера',
                                                {
                                                  'Режим': 'По замерам груди',
                                                },
                                              );
                                            }
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const _SizeSolutionWidget(
                                                sizerType: 'Грудь',
                                              ),
                                            );
                                          },
                                          child:
                                              const Text('По замерам груди')),
                                      TextButton(
                                          onPressed: () {
                                            if (kReleaseMode) {
                                              AppMetrica.reportEventWithMap(
                                                'Выбран режим калькуляции размера',
                                                {
                                                  'Режим': 'По замерам талии',
                                                },
                                              );
                                            }
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const _SizeSolutionWidget(
                                                sizerType: 'Талия',
                                              ),
                                            );
                                          },
                                          child:
                                              const Text('По размерам талии')),
                                      TextButton(
                                          onPressed: () {
                                            if (kReleaseMode) {
                                              AppMetrica.reportEventWithMap(
                                                'Выбран режим калькуляции размера',
                                                {
                                                  'Режим':
                                                      'По размеру брюк/джинс',
                                                },
                                              );
                                            }
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const _SizeSolutionWidget(
                                                sizerType: 'Брюки',
                                              ),
                                            );
                                          },
                                          child: const Text(
                                              'По размеру брюк/джинс')),
                                      TextButton(
                                          onPressed: () {
                                            if (kReleaseMode) {
                                              AppMetrica.reportEventWithMap(
                                                'Выбран режим калькуляции размера',
                                                {
                                                  'Режим': 'По росту',
                                                },
                                              );
                                            }
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const _SizeSolutionWidget(
                                                sizerType: 'Рост',
                                              ),
                                            );
                                          },
                                          child: const Text('По росту')),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('Как выбрать размер/рост?'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            child: RichText(
              text: TextSpan(
                text: isChecked ? 'ПРИОБРЕТЕНО' : 'ПРИОБРЕСТИ',
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SizeSolutionWidget extends StatefulWidget {
  const _SizeSolutionWidget({
    required this.sizerType,
  });

  final String sizerType;

  @override
  State<_SizeSolutionWidget> createState() => _SizeSolutionWidgetState();
}

class _SizeSolutionWidgetState extends State<_SizeSolutionWidget> {
  final TextEditingController _controller = TextEditingController();
  String size = '';

  String _calculateSize(String size) {
    if (kReleaseMode) {
      AppMetrica.reportEventWithMap(
        'Калькуляция размера',
        {
          'Режим': widget.sizerType,
          'Размер': size,
        },
      );
    }
    double? result = double.tryParse(size.replaceAll(',', '.'));
    return result == null
        ? 'размер не распознан'
        : widget.sizerType == 'Грудь'
            ? result >= 78 && result <= 85
                ? 'размер: 40-42'
                : result >= 86 && result <= 93
                    ? 'размер: 44-46'
                    : result >= 94 && result <= 101
                        ? 'размер: 48-50'
                        : result >= 102 && result <= 109
                            ? 'размер: 52-54'
                            : result >= 110 && result <= 117
                                ? 'размер: 56-58'
                                : result >= 118 && result <= 125
                                    ? 'размер: 60-62'
                                    : result >= 126 && result <= 133
                                        ? 'размер: 64-66'
                                        : 'размер не поддерживается'
            : widget.sizerType == 'Талия'
                ? result >= 66 && result <= 73
                    ? 'размер: 40-42'
                    : result >= 74 && result <= 81
                        ? 'размер: 44-46'
                        : result >= 82 && result <= 89
                            ? 'размер: 48-50'
                            : result >= 90 && result <= 97
                                ? 'размер: 52-54'
                                : result >= 98 && result <= 105
                                    ? 'размер: 56-58'
                                    : result >= 106 && result <= 113
                                        ? 'размер: 60-62'
                                        : result >= 114 && result <= 121
                                            ? 'размер: 64-66'
                                            : 'размер не поддерживается'
                : widget.sizerType == 'Брюки'
                    ? result >= 26 && result <= 29
                        ? 'размер: 40-42'
                        : result >= 30 && result <= 31
                            ? 'размер: 44-46'
                            : result >= 32 && result <= 34
                                ? 'размер: 48-50'
                                : result >= 35 && result <= 38
                                    ? 'размер: 52-54'
                                    : result >= 39 && result <= 42
                                        ? 'размер: 56-58'
                                        : result >= 44 && result <= 48
                                            ? 'размер: 60-62'
                                            : result >= 49 && result <= 51
                                                ? 'размер: 64-66'
                                                : 'размер не поддерживается'
                    : widget.sizerType == 'Рост'
                        ? result >= 155 && result <= 169
                            ? 'рост: 1-2'
                            : result >= 170 && result <= 179
                                ? 'рост: 3-4'
                                : result >= 180 && result <= 195
                                    ? 'рост: 5-7'
                                    : 'рост не поддерживается'
                        : throw Exception('Ошибка');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.9),
      surfaceTintColor: Colors.black,
      title: Text(
        widget.sizerType == 'Грудь'
            ? 'Замер груди'
            : widget.sizerType == 'Талия'
                ? 'Замер талии'
                : widget.sizerType == 'Брюки'
                    ? 'Размер брюк/джинс'
                    : 'Подобрать по росту',
        style: const TextStyle(color: Colors.deepOrange),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset(
                widget.sizerType == 'Грудь'
                    ? 'assets/images/chest.JPG'
                    : widget.sizerType == 'Талия'
                        ? 'assets/images/waist.JPG'
                        : widget.sizerType == 'Брюки'
                            ? 'assets/images/pants.jpg'
                            : widget.sizerType == 'Рост'
                                ? 'assets/images/height.JPG'
                                : 'assets/images/favicon.png',
              ),
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              onTap: () {
                GetIt.I<SizesConfig>().isKeyboardOpen = true;
              },
              onEditingComplete: () async {
                await GetIt.I<SizesConfig>().disableKeyboardFlag();
              },
              onSubmitted: (String value) => setState(() {
                try {
                  size = _calculateSize(value);
                } catch (e, st) {
                  GetIt.I<Talker>().handle(e, st);
                  AppMetrica.reportError(
                      message: 'Ошибка калькуляции: $e',
                      errorDescription:
                          AppMetricaErrorDescription.fromCurrentStackTrace());
                }
              }),
              decoration: InputDecoration(
                hintText:
                    widget.sizerType == 'Брюки' ? 'Размер' : 'Сантиметров',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const Spacer(),
            Text(
              size.isEmpty ? '' : 'Ваш $size',
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () => setState(
                          () {
                            try {
                              size = _calculateSize(_controller.text);
                            } catch (e, st) {
                              GetIt.I<Talker>().handle(e, st);
                              AppMetrica.reportError(
                                  message: 'Ошибка калькуляции: $e',
                                  errorDescription: AppMetricaErrorDescription
                                      .fromCurrentStackTrace());
                            }
                          },
                        ),
                    // Navigator.pop(context);

                    child: const Text('Рассчитать\nразмер')),
                TextButton(
                    onPressed: () async {
                      await GetIt.I<SizesConfig>().disableKeyboardFlag();
                      Navigator.pop(context);
                    },
                    child: const Text('Вернуться\nк магазинам')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FeaturesListWidget extends StatelessWidget {
  const _FeaturesListWidget({
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item.features.length,
          itemBuilder: (context, featureIndex) => featureIndex + 1 ==
                  item.features.length
              ? Column(
                  children: [
                    const Divider(thickness: 1),
                    AutoSizeText('${item.features[featureIndex]}', maxLines: 2),
                  ],
                )
              : AutoSizeText('● ${item.features[featureIndex]}', maxLines: 2),
        ),
      ),
    );
  }
}

class _LayerWidget extends StatelessWidget {
  const _LayerWidget({
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return item.inSuitLayer != null
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: AutoSizeText(
              '${item.inSuitLayer}',
              style: const TextStyle(fontSize: 20),
              maxLines: 1,
            ),
          )
        : const SizedBox.shrink();
  }
}

class _NecessaryWidget extends StatelessWidget {
  const _NecessaryWidget({
    required this.index,
    required this.item,
  });

  final int index;
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        index == 0 ? 'Рекомендуется' : 'Альтернатива',
        style: TextStyle(color: index == 0 ? Colors.deepOrange : Colors.grey),
      ),
    );
  }
}
