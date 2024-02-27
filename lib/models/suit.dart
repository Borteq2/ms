import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/models/_models.dart';

part 'suit.g.dart';

@JsonSerializable()
class Suit extends _Suit with _$Suit {
  Suit({
    required String name,
    required List<Clothing> clothes,
    required List<Accessory> accessories,
  }) : super(
          name: name,
          clothes: clothes,
          accessories: accessories,
        );

  factory Suit.fromJson(Map<String, dynamic> json) => _$SuitFromJson(json);

  Map<String, dynamic> toJson() => _$SuitToJson(this);
}

abstract class _Suit with Store {
  _Suit({
    required this.name,
    required this.clothes,
    required this.accessories,
  });

  @observable
  String name;

  @observable
  List<Clothing> clothes;

  @observable
  List<Accessory> accessories;
}
