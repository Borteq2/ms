import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'clothing_memory_store.g.dart';

class ClothingMemoryStore = _ClothingMemoryStore with _$ClothingMemoryStore;

abstract class _ClothingMemoryStore with Store {
  _ClothingMemoryStore({
    required this.talker,
  });

  final Talker talker;
  final Box<Clothing> clothingBox =
      GetIt.I<Box<Clothing>>(instanceName: 'clothing_box');
  final Box<Accessory> accessoryBox =
      GetIt.I<Box<Accessory>>(instanceName: 'accessory_box');

// =============================== observable ==================================

  @observable
  ObservableList<Clothing> boxedClothingList = ObservableList.of([]);

  @observable
  ObservableList<Accessory> boxedAccessoryList = ObservableList.of([]);

// =============================== computed ====================================

  // @computed

// ============================== action =======================================

  @action
  Future<void> syncHasAlreadyListsWithBoxes() async {
    // talker.debug('Синхронизирую списки "добавленных" с боксами');
    talker.debug('Обнуляю текущие');
    try {
      dropUnboxedLists();
      talker.debug('Дёргаю шмотки');
      await getClothingListFromBox();
      talker.debug('Дёргаю аксы');
      await getAccessoryListFromBox();
    } catch (e, st) {
      talker.handle(e, st);
    }
    talker.debug(
      'Списки синхронизированы. Шмотки: ${boxedClothingList.length}, аксы: ${boxedAccessoryList.length}',
    );
  }

  @action
  Future<void> getClothingListFromBox() async {
    talker.info('Получаю шмотки из бокса');
    try {
      for (Clothing item in clothingBox.values) {
        talker.debug('Записываю в список из бокса шмотку\n$item');
        boxedClothingList.add(item);
      }
      talker.info('Список анбокснутых шмоток:\n$boxedClothingList');
    } catch (e, st) {
      talker.handle(e, st);
    }
  }

  @action
  Future<void> getAccessoryListFromBox() async {
    talker.info('Получаю аксы из бокса');
    try {
      for (Accessory item in accessoryBox.values) {
        talker.debug('Записываю в список из бокса акс\n$item');
        boxedAccessoryList.add(item);
      }
      talker.info('Список анбокснутых аксов:\n$boxedAccessoryList');
    } catch (e, st) {
      talker.handle(e, st);
    }
  }

  @action
  void dropUnboxedLists() {
    talker.warning('Дропаю листы имеющихся шмоток и аксов');
    try {
      boxedClothingList.clear();
      boxedAccessoryList.clear();
    } catch (e, st) {
      talker.handle(e, st);
    }
  }

// =============================== subfuncs ====================================

  Future<void> setClothingToBox(Clothing clothing) async {
    talker.info('Сохраняю шмотку ${clothing.name} в clothingBox');
    try {
      await clothingBox.put(clothing.name, clothing);
    } catch (e, st) {
      talker.handle(e, st);
    }
    talker.info('Синхронизирую бокс и список');
    await syncHasAlreadyListsWithBoxes();
  }

  Future<void> removeClothingFromBox(Clothing clothing) async {
    talker.info('Удаляю шмотку ${clothing.name} из clothingBox');
    try {
      clothingBox.delete(clothing.name);
    } catch (e, st) {
      talker.handle(e, st);
    }
    talker.info('Синхронизирую бокс и список');
    await syncHasAlreadyListsWithBoxes();
  }

  Future<void> setAccessoryToBox(Accessory accessory) async {
    talker.info('Сохраняю аксессуар ${accessory.name} в accessoryBox');
    try {
      await accessoryBox.put(accessory.name, accessory);
    } catch (e, st) {
      talker.handle(e, st);
    }
    talker.info('Синхронизирую бокс и список');
    await syncHasAlreadyListsWithBoxes();
  }

  Future<void> removeAccessoryFromBox(Accessory accessory) async {
    talker.info('Удаляю акс ${accessory.name} из accessoryBox');
    try {
      accessoryBox.delete(accessory.name);
    } catch (e, st) {
      talker.handle(e, st);
    }
    talker.info('Синхронизирую бокс и список');
    await syncHasAlreadyListsWithBoxes();
  }

  Future<void> dropBoxes() async {
    talker.warning('Дропаю сами боксы');
    try {
      await clothingBox.clear();
      await accessoryBox.clear();
    } catch (e, st) {
      talker.handle(e, st);
    }
    talker.info('Синхронизирую бокс и список');
    await syncHasAlreadyListsWithBoxes();
  }
}
