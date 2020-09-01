import 'package:json_annotation/json_annotation.dart';

part 'rdm.g.dart';

@JsonSerializable()
class AppRefData {
  int dataId;
  String appName;

  String moduleName;

  String type;

  String key;
  String value;

  String groupName;
  String subGroupName;

  AppRefData();

  factory AppRefData.fromJson(Map<String, dynamic> json) =>
      _$AppRefDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppRefDataToJson(this);
}
