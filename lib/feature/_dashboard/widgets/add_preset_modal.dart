import 'package:flutter/material.dart';
import 'package:mordor_suit/library/helpers/report.dart';
import 'package:mordor_suit/store/_stores.dart';

class AddPresetModal extends StatefulWidget {
  final AppStore appStore;

  const AddPresetModal({
    Key? key,
    required this.appStore,
  }) : super(key: key);

  @override
  _AddPresetModalState createState() => _AddPresetModalState();
}

class _AddPresetModalState extends State<AddPresetModal> {
  late TextEditingController _cityNameController;

  @override
  void initState() {
    super.initState();
    _cityNameController = TextEditingController();
  }

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }

  LocationPresetsStore get locationPresetsStore =>
      widget.appStore.locationPresetsStore;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить город'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _cityNameController,
              decoration: const InputDecoration(labelText: 'Город'),
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
        TextButton(
          onPressed: () {
            Report.map(
              event: 'Добавлен пресет',
              map: {'Название локации': _cityNameController.text},
            );
            locationPresetsStore.addPreset(_cityNameController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}
