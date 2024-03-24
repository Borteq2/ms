import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mordor_suit/feature/_set/subfeatures/_item_card/_widgets.dart';
import 'package:mordor_suit/library/config/sizes.dart';
import 'package:mordor_suit/enums/_enums.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:mordor_suit/store/_stores.dart';

class ItemCardLinkWidget extends StatefulWidget {
  const ItemCardLinkWidget({
    super.key,
    required this.item,
    required this.appStore,
    required this.action,
  });

  final AppStore appStore;
  final VoidCallback action;
  final item;

  @override
  State<ItemCardLinkWidget> createState() => ItemCardLinkWidgetState();
}

class ItemCardLinkWidgetState extends State<ItemCardLinkWidget> {
  void _preloadBoxData() async {
    await widget.appStore.clothingMemoryStore.syncHasAlreadyListsWithBoxes();
    Report.map(
      event: 'Синхронизация наличия с кэшем',
      map: {'Товар': '${widget.item.name}', 'Результат': '$isChecked'},
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
            'Переход': '${widget.item.name} -> ${widget.item.linkToWb}',
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
            'Переход': '${widget.item.name} -> ${widget.item.linkToOzon}',
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

  bool get isChecked =>
      clothingMemoryStore.boxedClothingList.contains(widget.item);

  @override
  Widget build(BuildContext context) {
    Talker talker = GetIt.I<Talker>();

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
                      _generateStoreButton(
                        context,
                        item: widget.item,
                        store: LinkType.mordor,
                      ),
                      _generateStoreButton(
                        context,
                        item: widget.item,
                        store: LinkType.wb,
                      ),
                      _generateStoreButton(
                        context,
                        item: widget.item,
                        store: LinkType.ozon,
                      ),
                      _generateStoreButton(
                        context,
                        item: widget.item,
                        store: 'Showroom',
                      ),
                    ],
                  ),
                ),
                actions: _generateModalActionsWidget(context),
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

  Widget _generateStoreButton(
    BuildContext context, {
    required item,
    required store,
  }) =>
      widget.item == null
          ? const SizedBox.shrink()
          : store == LinkType.mordor
              ? TextButton(
                  onPressed: () => openLink(context, LinkType.mordor),
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
              : store == LinkType.wb
                  ? TextButton(
                      onPressed: () => openLink(context, LinkType.wb),
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
                  : store == LinkType.ozon
                      ? TextButton(
                          onPressed: () => openLink(context, LinkType.ozon),
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
                      : TextButton(
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
                              Icon(Icons.man, size: 40),
                              SizedBox(width: 20),
                              Text('Шоурум'),
                            ],
                          ),
                        );

  List<Widget> _generateModalActionsWidget(BuildContext context) {
    return <Widget>[
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
                    await clothingMemoryStore.setClothingToBox(widget.item);
                    Report.map(
                      event: 'Изменение наличия',
                      map: {
                        'Было': 'Нет',
                        'Стало': 'Есть',
                      },
                    );
                  }
                  widget.action();
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text(isChecked ? 'Продал' : 'Уже есть'),
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  await GetIt.I<SizesConfig>().disableKeyboardFlag();
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
                  return const ItemCardSizerTypeWidget();
                },
              );
            },
            child: const Text('Как выбрать размер/рост?'),
          ),
        ],
      )
    ];
  }
}
