import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mordor_suit/feature/_item_card/_widgets.dart';
import 'package:mordor_suit/feature/library/config/sizes.dart';
import 'package:mordor_suit/feature/library/enums.dart';
import 'package:mordor_suit/feature/library/logic/report.dart';
import 'package:mordor_suit/store/_stores.dart';

class ItemCardLinkWidget extends StatefulWidget {
  const ItemCardLinkWidget({
    super.key,
    required this.item,
    required this.appStore,
    required this.onHaveAlreadyBtnTap,
  });

  final AppStore appStore;
  final VoidCallback onHaveAlreadyBtnTap;
  final item;

  @override
  State<ItemCardLinkWidget> createState() => ItemCardLinkWidgetState();
}

class ItemCardLinkWidgetState extends State<ItemCardLinkWidget> {
  void _preloadBoxData() async {
    await appStore.clothingMemoryStore.syncHasAlreadyListsWithBoxes();
    Report.map(
      event: 'Синхронизация наличия с кэшем',
      map: {
        'Товар': '${widget.item.name}',
      },
    );
  }

  @override
  void initState() {
    _preloadBoxData();
    super.initState();
  }

  void openLink(BuildContext context, LinkType linkType) async {
    switch (linkType) {
      case LinkType.mordor:
        Report.map(
          event: 'Переход на сайт Мордор',
          map: {
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
        Report.map(
          event: 'Переход на Wildberries',
          map: {
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
        Report.map(
          event: 'Переход на Ozon',
          map: {
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

  ClothingMemoryStore get clothingMemoryStore =>
      widget.appStore.clothingMemoryStore;

  @override
  Widget build(BuildContext context) {
    Talker talker = GetIt.I<Talker>();

    bool isChecked;

    isChecked = clothingMemoryStore.boxedClothingList.contains(widget.item);

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
                          Report.map(
                            event: 'Построение маршрута в шоурум',
                            map: {
                              'Переход':
                                  '${widget.item.name} -> Маршрут навигатора в шоурум',
                            },
                          );

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
                                await clothingMemoryStore
                                    .removeClothingFromBox(widget.item);
                                Report.map(
                                  event: 'Изменение наличия',
                                  map: {
                                    'Было': 'Есть',
                                    'Стало': 'Нет',
                                  },
                                );
                              } else {
                                await clothingMemoryStore
                                    .setClothingToBox(widget.item);
                                Report.map(
                                  event: 'Изменение наличия',
                                  map: {
                                    'Было': 'Нет',
                                    'Стало': 'Есть',
                                  },
                                );
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
                          Report.map(
                            event: 'Открыто меню калькулятора размеров',
                            map: {
                              'Кнопка': 'Как выбрать размер/рост?',
                            },
                          );

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
                                            Report.map(
                                              event:
                                                  'Выбран режим калькуляции размера',
                                              map: {
                                                'Режим': 'По замерам груди',
                                              },
                                            );
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const ItemCardSizeSolutionWidget(
                                                sizerType: 'Грудь',
                                              ),
                                            );
                                          },
                                          child:
                                              const Text('По замерам груди')),
                                      TextButton(
                                          onPressed: () {
                                            Report.map(
                                              event:
                                                  'Выбран режим калькуляции размера',
                                              map: {
                                                'Режим': 'По замерам талии',
                                              },
                                            );

                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const ItemCardSizeSolutionWidget(
                                                sizerType: 'Талия',
                                              ),
                                            );
                                          },
                                          child:
                                              const Text('По размерам талии')),
                                      TextButton(
                                          onPressed: () {
                                            Report.map(
                                              event:
                                                  'Выбран режим калькуляции размера',
                                              map: {
                                                'Режим':
                                                    'По размеру брюк/джинс',
                                              },
                                            );

                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const ItemCardSizeSolutionWidget(
                                                sizerType: 'Брюки',
                                              ),
                                            );
                                          },
                                          child: const Text(
                                              'По размеру брюк/джинс')),
                                      TextButton(
                                          onPressed: () {
                                            Report.map(
                                              event:
                                                  'Выбран режим калькуляции размера',
                                              map: {
                                                'Режим': 'По росту',
                                              },
                                            );

                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const ItemCardSizeSolutionWidget(
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
