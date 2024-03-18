import 'package:mobx/mobx.dart';

part 'sizes.g.dart';

class SizesConfig = _SizesConfig with _$SizesConfig;

abstract class _SizesConfig with Store {
  @observable
  bool isKeyboardOpen = false;

  @computed
  double get cardHeightModifier => isKeyboardOpen ? 0.8 : 1;

  @computed
  double get cardWidthModifier => isKeyboardOpen ? 1 : 1;

  @action
  Future<void> disableKeyboardFlag() async {
    Future.delayed(const Duration(milliseconds: 200), () {
      isKeyboardOpen = false;
    });
  }
}
