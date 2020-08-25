

import 'package:paroont_realty_mobile/constant/paroont_const.dart';

class Rdm {
  static final Rdm _instance = Rdm._internal();
  final Map<String, Map> types = Map();

  factory Rdm() {
    return _instance;
  }

  Rdm._internal() {
    types[ARD_PROPERTY_TYPE_GROUP] = {'1': 'Residential', '2': 'Commerical'};
    types[ARD_PROPERTY_TYPE] = {'1': 'Apartment', '2': 'Independent Builder'};
    types[ARD_PROPERTY_CONFIGURATION_TYPE] = {'1': '1 RK', '2': '1 BHK', '4':'2 BHK'};
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
}
