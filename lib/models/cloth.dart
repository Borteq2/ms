import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'cloth.g.dart';

@JsonSerializable()
class Clothing extends _Cloth with _$Clothing {
  Clothing({
    required String name,
    required String linkToStore,
    required List<String> features,
    required String image,
    required int inSuitLayer,
    required bool isNecessary,
  }) : super(
          name: name,
          linkToStore: linkToStore,
          features: features,
          image: image,
          inSuitLayer: inSuitLayer,
          isNecessary: isNecessary,
        );

  factory Clothing.fromJson(Map<String, dynamic> json) =>
      _$ClothingFromJson(json);

  Map<String, dynamic> toJson() => _$ClothingToJson(this);
}

abstract class _Cloth with Store {
  _Cloth({
    required this.name,
    required this.linkToStore,
    required this.features,
    required this.image,
    required this.inSuitLayer,
    required this.isNecessary,
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
  int inSuitLayer;

  @observable
  bool isNecessary;
}
