import 'package:paroont_realty_mobile/constant/ui_const.dart';
import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/constant/url_const.dart';
import 'package:paroont_realty_mobile/service/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:paroont_realty_mobile/util/common_util.dart';

class PropertyService {
  static final PropertyService _instance = PropertyService._internal();
  static final PropertyFilter filter = PropertyFilter();
  static final PropertyFilter myFilter = PropertyFilter();
  factory PropertyService() {
    return _instance;
  }

  PropertyService._internal();

  PropertyFilter getFilter() {
    return filter;
  }

  PropertyFilter getMyFilter() {
    return myFilter;
  }

  Future<CorePaginationData<PropertyDetail>> allProperties(
      PropertyFilter filter,
      {bool myProperty: false}) async {
    CorePaginationData<PropertyDetail> pageData = CorePaginationData();
    String url = URL_REALTY_CACHE_PROPERTY;
    if (myProperty) {
      url = URL_REALTY_PROPERTY;
      String uid = UserService().getUser().takeUserId();
      if (!filter.postedByIds.contains(uid)) {
        filter.postedByIds.add(uid);
      }
    }

    var uri = Uri.http(URL_REALTY_API_HOST, url, filter.toMap());
    final response = await http.get(uri);
    String errorMsg = 'Failed to load properties.';
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      if (jsonMap['status'] == true) {
        pageData.totalRecords = jsonMap['totalRecords'] as int;
        pageData.data = (jsonMap['data'] as List)
            .map((e) => PropertyDetail.fromJson(e))
            .toList();
      } else {
        throw Exception(errorMsg);
      }
    } else {
      throw Exception(errorMsg);
    }
    return pageData;
  }

  Future<PropertySaveResponse> saveProperty(PropertyDetail pd) async {
    PropertySaveResponse propertyResponse = PropertySaveResponse();
    updatePostedByDetails(pd);
    var uri = Uri.http(URL_REALTY_API_HOST,
        URL_REALTY_PROPERTY + "/" + pd.propertyId.toString());

    String jsonStr = jsonEncode(pd);
    String uid = UserService().getUser().takeUserId();

    final response = await http.put(uri, body: jsonStr, headers: {
      "Content-Type": "application/json",
      URL_COMMON_PARAM_HEADER_PAROONT_UID: uid
    });
    String errorMsg = UI_MSG_POST_PROPERTY_SAVE_ERROR;

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      propertyResponse = PropertySaveResponse.fromJson(jsonMap);
    } else {
      propertyResponse.message = errorMsg;
    }
    return propertyResponse;
  }

  void updatePostedByDetails(PropertyDetail pd) {
    if (notNullStr(pd.postedBy).isEmpty) {
      pd.postedBy = UserService().getUser().takeUserId();
    }
    if(pd.propertyId<=0){
      pd.statusId = ARD_COMMON_KEY_ACTIVE;
    }
  }

  Future<CorePaginationData<PropertyDetail>> allMyProperties3(
      PropertyFilter filter) async {
    CorePaginationData<PropertyDetail> pageData = CorePaginationData();

    String uid = UserService().getUser().takeUserId();

    if (!filter.postedByIds.contains(uid)) {
      filter.postedByIds.add(uid);
    }

    var uri =
        Uri.http(URL_REALTY_API_HOST, URL_REALTY_PROPERTY, filter.toMap());

    final response = await http.get(uri);
    String errorMsg = 'Failed to load properties.';

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      if (jsonMap['status'] == true) {
        pageData.totalRecords = jsonMap['totalRecords'] as int;
        pageData.data = (jsonMap['data'] as List)
            .map((e) => PropertyDetail.fromJson(e))
            .toList();
      } else {
        throw Exception(errorMsg);
      }
    } else {
      throw Exception(errorMsg);
    }
    return pageData;
  }
}
