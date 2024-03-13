import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/models/_models.dart';

part 'suit.g.dart';

@JsonSerializable()
class Suit extends _Suit with _$Suit {
  Suit({
    required String name,
    required List<Clothing>? layer_1,
    required List<Clothing>? layer_2,
    required List<Clothing>? layer_3,
    required List<Clothing>? layer_4_top,
    required List<Clothing>? layer_4_bot,
    required List<Clothing>? layer_5_top,
    required List<Clothing>? layer_5_bot,
    required List<Clothing>? layer_6,
    required List<Clothing>? layer_7,
    required List<Clothing>? layer_8,
    required List<Clothing>? layer_9,
    required List<Clothing>? head,
    required List<Clothing>? accessories,
  }) : super(
          name: name,
          layer_1: layer_1,
          layer_2: layer_2,
          layer_3: layer_3,
          layer_4_top: layer_4_top,
          layer_4_bot: layer_4_bot,
          layer_5_top: layer_5_top,
          layer_5_bot: layer_5_bot,
          layer_6: layer_6,
          layer_7: layer_7,
          layer_8: layer_8,
          layer_9: layer_9,
          head: head,
          accessories: accessories,
        );

  factory Suit.fromJson(Map<String, dynamic> json) => _$SuitFromJson(json);

  Map<String, dynamic> toJson() => _$SuitToJson(this);
}

abstract class _Suit with Store {
  _Suit({
    required this.name,
    required this.layer_1,
    required this.layer_2,
    required this.layer_3,
    required this.layer_4_top,
    required this.layer_4_bot,
    required this.layer_5_top,
    required this.layer_5_bot,
    required this.layer_6,
    required this.layer_7,
    required this.layer_8,
    required this.layer_9,
    required this.head,
    required this.accessories,
  });

  @observable
  String name;

  @observable
  List<Clothing>? layer_1;

  @observable
  List<Clothing>? layer_2;

  @observable
  List<Clothing>? layer_3;

  @observable
  List<Clothing>? layer_4;

  @observable
  List<Clothing>? layer_4_top;

  @observable
  List<Clothing>? layer_4_bot;

  @observable
  List<Clothing>? layer_5_top;

  @observable
  List<Clothing>? layer_5_bot;

  @observable
  List<Clothing>? layer_6;

  @observable
  List<Clothing>? layer_7;

  @observable
  List<Clothing>? layer_8;

  @observable
  List<Clothing>? layer_9;

  @observable
  List<Clothing>? head;

  @observable
  List<Clothing>? accessories;
}
