import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:paroont_realty_mobile/constant/url_const.dart';
import 'package:paroont_realty_mobile/model/rdm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RdmService {
  static final RdmService _instance = RdmService._internal();
  final Map<String, Map<String, String>> types = Map();

  factory RdmService() {
    return _instance;
  }

  Future<void> loadAllAppRefData() async {
    var uri = Uri.http(URL_REALTY_API_HOST, URL_REALTY_RDM_ARD);

    final response = await http.get(uri);
    String errorMsg = 'Failed to load ref data.';

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      if (jsonMap['status'] == true) {
        (jsonMap['data'] as List)
            .map((e) => AppRefData.fromJson(e))
            .toList()
            .forEach((e) => _updateRefData(e));
      } else {
        throw Exception(errorMsg);
      }
    } else {
      throw Exception(errorMsg);
    }
  }

  void _updateRefData(AppRefData ard) {
    if (null != ard) {
      var typeMap = types[ard.type];
      if (null == typeMap) {
        typeMap = Map();
        types[ard.type] = typeMap;
      }
      typeMap[ard.key] = ard.value;
    }
  }

  RdmService._internal();

  Map _keyValueByType(String type) {
    return types[type];
  }

  String _valueByKey(String type, String key) {
    String value = '';
    Map map = types[type];
    if (null != map) {
      value = map[key];
    }
    return value;
  }

  Map<String, String>  propertyTypes() {
    return _keyValueByType(ARD_PROPERTY_TYPE);
  }

  String propertyTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_TYPE, key.toString());
  }

  Map<String,String> propertyTypeGroups() {
    return _keyValueByType(ARD_PROPERTY_TYPE_GROUP);
  }

  String propertyTypeGroupsValue(int key) {
    return _valueByKey(ARD_PROPERTY_TYPE_GROUP, key.toString());
  }

  Map<String,String> propertyConfigTypes() {
    return _keyValueByType(ARD_PROPERTY_CONFIGURATION_TYPE);
  }

  String propertyConfigTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_CONFIGURATION_TYPE, key.toString());
  }

  Map<String, String>  propertyAreaUnitTypes() {
    return _keyValueByType(ARD_PROPERTY_AREA_UNIT);
  }

  String propertyAreaUnitTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_AREA_UNIT, key.toString());
  }

  Map<String, String>  propertyAreaTypes() {
    return _keyValueByType(ARD_PROPERTY_AREA_TYPE);
  }

  String propertyAreaTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_AREA_TYPE, key.toString());
  }

  Map<String,String> propertyAvailableTypes() {
    return _keyValueByType(ARD_PROPERTY_AVAILABLE_TYPE);
  }

  String propertyAvailableTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_AVAILABLE_TYPE, key.toString());
  }

  Map<String,String> propertyFurnishTypes() {
    return _keyValueByType(ARD_PROPERTY_FURNISH_TYPE);
  }

  String propertyFurnishTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_FURNISH_TYPE, key.toString());
  }

  Map<String,String> propertyAgeTypes() {
    return _keyValueByType(ARD_PROPERTY_AGE_TYPE);
  }

  String propertyAgeTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_AGE_TYPE, key.toString());
  }

  Map<String,String> propertyFloorNoTypes() {
    return _keyValueByType(ARD_FLOOR_NO_TYPE);
  }

  String propertyFloorNoTypeValue(int key) {
    return _valueByKey(ARD_FLOOR_NO_TYPE, key.toString());
  }

  Map<String,String> propertyPreferredTenantTypes() {
    return _keyValueByType(ARD_PREFERRED_TENANT_TYPE);
  }

  String propertyPreferredTenantTypeValue(int key) {
    return _valueByKey(ARD_PREFERRED_TENANT_TYPE, key.toString());
  }

  Map<String, String> propertyTransactionTypes() {
    return _keyValueByType(ARD_PROPERTY_TRANSACTION_TYPE);
  }

  String propertyTransactionTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_TRANSACTION_TYPE, key.toString());
  }

  Map<String,String> propertyProfileTypes() {
    return _keyValueByType(ARD_PROPERTY_PROFILE_TYPE);
  }

  Map<String,String> propertyFaceTypes() {
    return _keyValueByType(ARD_PROPERTY_FACE_TYPE);
  }

  Map<String, String>  propertySaleTypes() {
    Map<String, String> dataMap = Map();
    dataMap['1'] = 'New';
    dataMap['2'] = 'Resale';
    return dataMap;
  }
}
