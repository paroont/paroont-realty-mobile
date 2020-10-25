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
AppRefData.keyValue(this.key, this.value) ;
AppRefData.short(this.dataId, this.type, this.key, this.value) ;
AppRefData.long(this.dataId, this.type, this.key, this.value, this.groupName) ;

  factory AppRefData.fromJson(Map<String, dynamic> json) =>
      _$AppRefDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppRefDataToJson(this);
}
