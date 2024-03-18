import 'package:flutter/material.dart';

import 'package:mordor_suit/feature/_set/subfeatures/_item_card/_widgets.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';

class ItemCardSizerTypeWidget extends StatelessWidget {
  const ItemCardSizerTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.9),
      surfaceTintColor: Colors.black,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _generateSizerModalWidgetByType(
              context,
              type: 'Грудь',
              buttonText: 'По размерам груди',
            ),
            _generateSizerModalWidgetByType(
              context,
              type: 'Талия',
              buttonText: 'По замерам талии',
            ),
            _generateSizerModalWidgetByType(
              context,
              type: 'Брюки',
              buttonText: 'По размеру брюк/джинс',
            ),
            _generateSizerModalWidgetByType(
              context,
              type: 'Рост',
              buttonText: 'По росту',
            ),
          ],
        ),
      ),
    );
  }

  TextButton _generateSizerModalWidgetByType(
    BuildContext context, {
    required String type,
    required String buttonText,
  }) {
    return TextButton(
        onPressed: () {
          Report.map(
            event: 'Выбран режим калькуляции размера',
            map: {
              'Режим': buttonText,
            },
          );
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => ItemCardSizeSolutionWidget(
              sizerType: type,
            ),
          );
        },
        child: Text(buttonText));
  }
}
