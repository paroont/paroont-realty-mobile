import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:paroont_realty_mobile/constant/url_const.dart';
import 'package:paroont_realty_mobile/model/rdm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RdmService {
  static final RdmService _instance = RdmService._internal();
  final Map<String, Map> types = Map();

  factory RdmService() {
    return _instance;
  }

  Future<void> loadAllAppRefData() async {
    final response = await http.get(fullApiUrl(URL_REALTY_RDM_ARD));
    String errorMsg = 'Failed to load ref data.';

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      if (jsonMap['status'] == true) {
       (jsonMap['data'] as List)
            .map((e) => AppRefData.fromJson(e))
            .toList().forEach((e) => _updateRefData(e));
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

  RdmService._internal() {
/*

    types[ARD_PROPERTY_TYPE_GROUP] = {'1': 'Residential', '2': 'Commerical'};
    types[ARD_PROPERTY_TYPE] = {'1': 'Apartment', '2': 'Independent Builder'};
    types[ARD_PROPERTY_CONFIGURATION_TYPE] = {
      
      '2': '1 BHK',
      '4': '2 BHK',
      '6': '3 BHK'
    };
    types[ARD_PROPERTY_AREA_UNIT] = {'1': 'sq. ft.', '2': 'sq. m.'};
    types[ARD_PROPERTY_AREA_TYPE] = {
      '1': 'Carpet',
      
      '2': 'Built Up',
      '3': 'Super Built Up'
    };
     types[ARD_PROPERTY_TRANSACTION_TYPE] = {
      '1': 'Sell',
      
      '2': 'Rent',
      '3': 'PG'
    };
    types[ARD_PROPERTY_AVAILABLE_TYPE] = {
      '1': 'Under Construction',
      '2': 'Ready To Move',
      '3': 'Immediately',
      '4': 'Date'
    };
    types[ARD_PROPERTY_FURNISH_TYPE] = {
      '1': 'Furnished',
      '2': 'Semi Furnished',
      '3': 'Unfurnished'
    };
    types[ARD_PROPERTY_AGE_TYPE] = {
      '1': 'Less than 5 Years',
      '2': '5 to 10 Years'
    };
    types[ARD_FLOOR_NO_TYPE] = {'1': 'No', '2': 'Higher', '3':'Middle'};
     types[ARD_PREFERED_TENANT_TYPE] = {'1': 'Any', '2': 'Family', '3':'Bachelor'};
     */
  }

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

  Map propertyTypes() {
    return _keyValueByType(ARD_PROPERTY_TYPE);
  }

  String propertyTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_TYPE, key.toString());
  }

  Map propertyTypeGroups() {
    return _keyValueByType(ARD_PROPERTY_TYPE_GROUP);
  }

  String propertyTypeGroupsValue(int key) {
    return _valueByKey(ARD_PROPERTY_TYPE_GROUP, key.toString());
  }

  Map propertyConfigTypes() {
    return _keyValueByType(ARD_PROPERTY_CONFIGURATION_TYPE);
  }

  String propertyConfigTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_CONFIGURATION_TYPE, key.toString());
  }

  Map propertyAreaUnitTypes() {
    return _keyValueByType(ARD_PROPERTY_AREA_UNIT);
  }

  String propertyAreaUnitTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_AREA_UNIT, key.toString());
  }

  Map propertyAreaTypes() {
    return _keyValueByType(ARD_PROPERTY_AREA_TYPE);
  }

  String propertyAreaTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_AREA_TYPE, key.toString());
  }

  Map propertyAvailableTypes() {
    return _keyValueByType(ARD_PROPERTY_AVAILABLE_TYPE);
  }

  String propertyAvailableTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_AVAILABLE_TYPE, key.toString());
  }

  Map propertyFurnishTypes() {
    return _keyValueByType(ARD_PROPERTY_FURNISH_TYPE);
  }

  String propertyFurnishTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_FURNISH_TYPE, key.toString());
  }

  Map propertyAgeTypes() {
    return _keyValueByType(ARD_PROPERTY_AGE_TYPE);
  }

  String propertyAgeTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_AGE_TYPE, key.toString());
  }

  Map propertyFloorNoTypes() {
    return _keyValueByType(ARD_FLOOR_NO_TYPE);
  }

  String propertyFloorNoTypeValue(int key) {
    return _valueByKey(ARD_FLOOR_NO_TYPE, key.toString());
  }

  Map propertyPreferredTenantTypes() {
    return _keyValueByType(ARD_PREFERED_TENANT_TYPE);
  }

  String propertyPreferredTenantTypeValue(int key) {
    return _valueByKey(ARD_PREFERED_TENANT_TYPE, key.toString());
  }

  Map propertyTransactionTypes() {
    return _keyValueByType(ARD_PROPERTY_TRANSACTION_TYPE);
  }

  String propertyTransactionTypeValue(int key) {
    return _valueByKey(ARD_PROPERTY_TRANSACTION_TYPE, key.toString());
  }
}
