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
    required List<Clothing>? layer_4,
    required List<Clothing>? layer_4a,
    required List<Clothing>? layer_5,
    required List<Accessory> accessories,
  }) : super(
          name: name,
          layer_1: layer_1,
          layer_2: layer_2,
          layer_3: layer_3,
          layer_4: layer_4,
          layer_4a: layer_4a,
          layer_5: layer_5,
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
    required this.layer_4,
    required this.layer_4a,
    required this.layer_5,
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
  List<Clothing>? layer_4a;

  @observable
  List<Clothing>? layer_5;

  @observable
  List<Accessory> accessories;
}
