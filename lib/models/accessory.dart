import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'accessory.g.dart';

@JsonSerializable()
class Accessory extends _Accessory with _$Accessory {
  Accessory({
    required String name,
    required String linkToStore,
    required List<String> features,
    required String image,
    required int? inSuitLayer,
    required bool isNecessary,
    required bool isHasAlready,
  }) : super(
    name: name,
    linkToStore: linkToStore,
    features: features,
    image: image,
    inSuitLayer: inSuitLayer,
    isNecessary: isNecessary,
    isHasAlready: isHasAlready,
  );

  factory Accessory.fromJson(Map<String, dynamic> json) => _$AccessoryFromJson(json);

  Map<String, dynamic> toJson() => _$AccessoryToJson(this);
}


abstract class _Accessory with Store {
  _Accessory({
    required this.name,
    required this.linkToStore,
    required this.features,
    required this.image,
    required this.inSuitLayer,
    required this.isNecessary,
    required this.isHasAlready,
  });

  @observable
  String name;

  @observable
  String linkToStore;

  @observable
  List<String> features;

  @observable
  String image;

  @observable
  int? inSuitLayer;

  @observable
  bool isNecessary;

  @observable
  bool isHasAlready;
}