// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rdm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppRefData _$AppRefDataFromJson(Map<String, dynamic> json) {
  return AppRefData()
    ..dataId = json['dataId'] as int
    ..appName = json['appName'] as String
    ..moduleName = json['moduleName'] as String
    ..type = json['type'] as String
    ..key = json['key'] as String
    ..value = json['value'] as String
    ..groupName = json['groupName'] as String
    ..subGroupName = json['subGroupName'] as String;
}

Map<String, dynamic> _$AppRefDataToJson(AppRefData instance) =>
    <String, dynamic>{
      'dataId': instance.dataId,
      'appName': instance.appName,
      'moduleName': instance.moduleName,
      'type': instance.type,
      'key': instance.key,
      'value': instance.value,
      'groupName': instance.groupName,
      'subGroupName': instance.subGroupName,
    };
