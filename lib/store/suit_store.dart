import 'package:mobx/mobx.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'suit_store.g.dart';

class SuitStore = _SuitStore with _$SuitStore;

abstract class _SuitStore with Store {
  _SuitStore({
    required this.talker,
  });

  final Talker talker;

// =============================================================================

// @computed

// =============================================================================

// @action

// =============================================================================

// func
}
