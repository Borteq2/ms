import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:hive/hive.dart';

import 'package:mordor_suit/feature/library/config/hive_types.dart';

part 'accessory.g.dart';

@HiveType(typeId: accessory)
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Accessory &&
        other.name == name &&
        other.linkToStore == linkToStore &&
        // ListEquality().equals(other.features, features) &&
        other.image == image &&
        other.inSuitLayer == inSuitLayer &&
        other.isNecessary == isNecessary;
    // &&
    // other.isHasAlready == isHasAlready;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      linkToStore,
      // ListEquality().hash(features),
      image,
      inSuitLayer,
      isNecessary,
      // isHasAlready,
    );
  }
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
  int? inSuitLayer;

  @HiveField(5)
  @observable
  bool isNecessary;

  @HiveField(6)
  @observable
  bool isHasAlready;
}