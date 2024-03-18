import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mordor_suit/library/config/sizes.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ItemCardSizeSolutionWidget extends StatefulWidget {
  const ItemCardSizeSolutionWidget({
    super.key,
    required this.sizerType,
  });

  final String sizerType;

  @override
  State<ItemCardSizeSolutionWidget> createState() =>
      ItemCardSizeSolutionWidgetState();
}

class ItemCardSizeSolutionWidgetState
    extends State<ItemCardSizeSolutionWidget> {
  final TextEditingController _controller = TextEditingController();
  String size = '';

  String _calculateSize(String size) {
    Report.map(
      event: 'Калькуляция размера',
      map: {
        'Режим': widget.sizerType,
        'Размер': size,
      },
    );

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
                FocusScope.of(context).unfocus();
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
