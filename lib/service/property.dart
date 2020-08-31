import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/constant/url_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PropertyService {
  static final PropertyService _instance = PropertyService._internal();

  factory PropertyService() {
    return _instance;
  }

  PropertyService._internal();

  Future<List<PropertyDetail>> allProperties() async {
    List<PropertyDetail> properties = List();
    final response = await http.get(fullApiUrl(URL_REALTY_PROPERTY));
    String errorMsg = 'Failed to load properties.';

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      if (jsonMap['status'] == true) {
        properties = (jsonMap['data'] as List)
            .map((e) => PropertyDetail.fromJson(e))
            .toList();
      } else {
        throw Exception(errorMsg);
      }
    } else {
      throw Exception(errorMsg);
    }
    return properties;
  }
}
