import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/library/config/hive_types.dart';

part 'clothing.g.dart';

@HiveType(typeId: clothing)
@JsonSerializable()
class Clothing extends _Cloth with _$Clothing {
  Clothing({
    required String name,
    required String linkToStore,
    required List<String> features,
    required String image,
    required String? inSuitLayer,
    required bool? isNecessary,
    required bool? isHasAlready,
    required String? linkToWb,
    required String? linkToOzon,
  }) : super(
          name: name,
          linkToStore: linkToStore,
          features: features,
          image: image,
          inSuitLayer: inSuitLayer,
          isNecessary: isNecessary,
          isHasAlready: isHasAlready,
          linkToWb: linkToWb,
          linkToOzon: linkToOzon,
        );

  factory Clothing.fromJson(Map<String, dynamic> json) =>
      _$ClothingFromJson(json);

  Map<String, dynamic> toJson() => _$ClothingToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Clothing &&
        other.name == name &&
        other.linkToStore == linkToStore;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      linkToStore,
    );
  }
}

abstract class _Cloth with Store {
  _Cloth({
    required this.name,
    required this.linkToStore,
    required this.features,
    required this.image,
    required this.inSuitLayer,
    required this.isNecessary,
    required this.isHasAlready,
    required this.linkToWb,
    required this.linkToOzon,
  });

  @HiveField(0)
  @observable
  String name;

  @HiveField(1)
  @observable
  String linkToStore;

  @HiveField(2)
  @observable
  List<String> features;

  @HiveField(3)
  @observable
  String image;

  @HiveField(4)
  @observable
  String? inSuitLayer;

  @HiveField(5)
  @observable
  bool? isNecessary;

  @HiveField(6)
  @observable
  bool? isHasAlready;

  @HiveField(7)
  @observable
  String? linkToWb;

  @HiveField(8)
  @observable
  String? linkToOzon;
}
