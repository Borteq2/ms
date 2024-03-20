import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/exceptions/_exceptions.dart';
import 'package:mordor_suit/models/_models.dart';

part 'clothing_memory_store.g.dart';

AppStore _appStoreCMS = GetIt.I<AppStore>();

class ClothingMemoryStore = _ClothingMemoryStore with _$ClothingMemoryStore;

abstract class _ClothingMemoryStore with Store {
  _ClothingMemoryStore({
    required this.talker,
  });

  final Talker talker;
  final Box<Clothing> clothingBox =
      GetIt.I<Box<Clothing>>(instanceName: 'clothing_box');

// =============================== observable ==================================

  @observable
  ObservableList<Clothing> boxedClothingList = ObservableList.of([]);

// =============================== computed ====================================

  // @computed

// ============================== action =======================================

  @action
  Future<void> syncHasAlreadyListsWithBoxes() async {
    talker.debug('Синхронизирую списки "добавленных" с боксами');
    talker.debug('Обнуляю текущие');
    try {
      dropUnboxedLists();
      talker.debug('Дёргаю итемы');
      await getClothingListFromBox();
    } catch (e, st) {
      talker.handle(e, st);
      throw BoxException(e.toString());
    }
    talker.debug(
      'Списки синхронизированы. Итемов: ${boxedClothingList.length}',
    );
  }

  @action
  Future<void> getClothingListFromBox() async {
    talker.info('Получаю итемы из бокса');
    try {
      for (Clothing item in clothingBox.values) {
        talker.debug('Записываю в список из бокса итем\n$item');
        boxedClothingList.add(item);
      }
      talker.info('Список анбокснутых итемов:\n$boxedClothingList');
    } catch (e, st) {
      talker.handle(e, st);
      throw BoxException(e.toString());
    }
  }

  @action
  void dropUnboxedLists() {
    talker.info('Дропаю листы имеющихся итемов');
    try {
      boxedClothingList.clear();
    } catch (e, st) {
      talker.handle(e, st);
      throw BoxException(e.toString());
    }
  }

// =============================== subfuncs ====================================

  Future<void> setClothingToBox(Clothing clothing) async {
    talker.info('Сохраняю итем ${clothing.name} в clothingBox');
    try {
      await clothingBox.put(clothing.name, clothing);
    } catch (e, st) {
      talker.handle(e, st);
      throw BoxException(e.toString());
    }
    talker.info('Синхронизирую бокс и список');
    await syncHasAlreadyListsWithBoxes();
  }

  Future<void> removeClothingFromBox(Clothing clothing) async {
    talker.info('Удаляю итем ${clothing.name} из clothingBox');
    try {
      clothingBox.delete(clothing.name);
    } catch (e, st) {
      talker.handle(e, st);
      throw BoxException(e.toString());
    }
    talker.info('Синхронизирую бокс и список');
    await syncHasAlreadyListsWithBoxes();
  }

  Future<void> dropBoxes() async {
    talker.info('Дропаю сами боксы');
    try {
      await clothingBox.clear();
    } catch (e, st) {
      talker.handle(e, st);
      throw BoxException(e.toString());
    }
    talker.info('Синхронизирую бокс и список');
    await syncHasAlreadyListsWithBoxes();
  }
}
