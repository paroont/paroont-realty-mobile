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

  Future<List<PropertyDetail>> allProperties(PropertyFilter filter) async {
    List<PropertyDetail> properties = List();
   var uri =  Uri.http(URL_REALTY_API_HOST, URL_REALTY_PROPERTY, filter.toMap());

    final response = await http.get(uri);
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
