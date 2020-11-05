import 'package:paroont_realty_mobile/model/user.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/constant/url_const.dart';
import 'package:paroont_realty_mobile/constant/ui_const.dart';
import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static final UserService _instance = UserService._internal();
  static final RealtyUser user = RealtyUser();
  factory UserService() {
    return _instance;
  }

  UserService._internal();

  RealtyUser getUser() {
    return user;
  }

  Future<CorePaginationData<UserProfile>> allUserProfiles(
      UserProfileFilter filter) async {
    CorePaginationData<UserProfile> pageData = CorePaginationData();
    var uri =
        Uri.http(URL_REALTY_API_HOST, URL_REALTY_USER_PROFILE, filter.toMap());
    final response = await http.get(uri);
    String errorMsg = 'Failed to load profile.';
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      if (jsonMap['status'] == true) {
        pageData.totalRecords = jsonMap['totalRecords'] as int;
        pageData.data = (jsonMap['data'] as List)
            .map((e) => UserProfile.fromJson(e))
            .toList();
      } else {
        throw Exception(errorMsg);
      }
    } else {
      throw Exception(errorMsg);
    }
    return pageData;
  }

  Future<UserProfileResponse> takeUserProfile({int userProfileId, String mobileNo, String mobileCountryCode, bool createIfNotExist:false}) async {
    UserProfileResponse profileResponse = UserProfileResponse();
    var filter = UserProfileFilter(userProfileId: userProfileId,
        mobileNo: mobileNo, mobileCountryCode: mobileCountryCode);
    CorePaginationData<UserProfile> profileData = await allUserProfiles(filter);
    if (profileData.data.length == 1) {
      profileResponse.status = true;
      profileResponse.data = profileData.data;
      profileResponse.message ="Profile exists";
    } else if (createIfNotExist) {
      UserProfile newProfile =
          UserProfile(mobileNo: mobileNo, mobileCountryCode: mobileCountryCode);
       profileResponse = await saveUserProfile(newProfile);
    }
    return profileResponse;
  }

  Future<UserProfileResponse> saveUserProfile(UserProfile profile) async {
    UserProfileResponse saveResponse = UserProfileResponse();
    var uri = Uri.http(URL_REALTY_API_HOST,
        URL_REALTY_USER_PROFILE + "/" + profile.userProfileId.toString());

    String jsonStr = jsonEncode(profile);
    String uid = getUser().takeUserId();

    final response = await http.put(uri, body: jsonStr, headers: {
      "Content-Type": "application/json",
      URL_COMMON_PARAM_HEADER_PAROONT_UID: uid
    });
    String errorMsg = UI_MSG_USER_PROFILE_SAVE_ERROR;

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      saveResponse = UserProfileResponse.fromJson(jsonMap);
    } else {
      saveResponse.message = errorMsg;
    }
    return saveResponse;
  }
}
