// import 'package:hive/hive.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:mobx/mobx.dart';
// import 'package:mordor_suit/library/config/hive_types.dart';
//
// part 'weather.g.dart';
//
// @HiveType(typeId: weather)
// @JsonSerializable()
// class Weather extends _Cloth with _$Weather {
//   Weather({
//     required String name,
//
//   }) : super(
//     name: name,
//
//   );
//
//   factory Weather.fromJson(Map<String, dynamic> json) =>
//       _$WeatherFromJson(json);
//
//   Map<String, dynamic> toJson() => _$WeatherToJson(this);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//
//     return other is Weather &&
//         other.name == name &&
//         other.linkToStore == linkToStore;
//   }
//
//   @override
//   int get hashCode {
//     return Object.hash(
//       name,
//       linkToStore,
//     );
//   }
// }
//
// abstract class _Weather with Store {
//   _Weather({
//     required this.name,
//     required this.linkToStore,
//   });
//
//   @HiveField(0)
//   @observable
//   String name;
//
//   @HiveField(1)
//   @observable
//   String linkToStore;
//
//   @HiveField(2)
//   @observable
//   List<String> features;
//
//   @HiveField(3)
//   @observable
//   String image;
//
//   @HiveField(4)
//   @observable
//   String? inSuitLayer;
//
//   @HiveField(5)
//   @observable
//   bool isNecessary;
//
//   @HiveField(6)
//   @observable
//   bool isHasAlready;
//
//   @HiveField(7)
//   @observable
//   String? linkToWb;
//
//   @HiveField(8)
//   @observable
//   String? linkToOzon;
// }
