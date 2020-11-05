import 'package:paroont_realty_mobile/model/common.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:paroont_realty_mobile/util/common_util.dart';

part 'user.g.dart';

@JsonSerializable()
class UserProfile with CoreObj {
  int userProfileId;
  String userId;
  String firstName;
  String lastName;
  String mobileNo;
  String mobileCountryCode;

  String emailId;
  String emailId2;
  String emailId3;

  int profileTypeId;

  String facebookId;
  String twitterId;
  String instagramId;

  String whatsAppNo;
  String whatsAppCountryCode;

  String contactNo2;
  String contactNo2CountryCode;
  String contactNo2Title;

  String contactNo3;
  String contactNo3CountryCode;
  String contactNo3Title;

  String addressLine1;
  String addressLine2;
  String cityId;
  String cityName;
  String stateId;
  String stateName;
  String landmarkId;
  String landmarkName;
  String pinCode;
  String countryName;

  String genderTitle;
  DateTime dob;

  int incomeRangeId;

  String companyName;
  String companyWebUrl;
  String companyOverview;

  String reraId;

  UserProfile(
      {this.userProfileId: 0,
      this.mobileNo,
      this.mobileCountryCode,
      this.emailId,
      statusId: 1,
      this.profileTypeId: 2});
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  String takeMobileCountryCode() {
    return _takeCountryCode(mobileCountryCode);
  }

  String takeWhatsAppCountryCode() {
    return _takeCountryCode(whatsAppCountryCode);
  }

  String takeContactNo2CountryCode() {
    return _takeCountryCode(contactNo2CountryCode);
  }

  String takeContactNo3CountryCode() {
    return _takeCountryCode(contactNo3CountryCode);
  }

  String _takeCountryCode(String countryCode) {
    return notBlankStr(countryCode) ? countryCode : ARD_COMMON_DEFAULT_ISD_CODE;
  }

  String takeFullName() {
    return notNullStr(firstName) + ' ' + notNullStr(lastName);
  }

  String takeMobileNo() {
    return takeMobileCountryCode() + mobileNo;
  }
}

class RealtyUser {
  bool loggedIn = false;
  UserProfile profile = new UserProfile();

  void logout() {
    loggedIn = false;
    profile = new UserProfile();
  }

  void login(UserProfile profile) {
    loggedIn = true;
    this.profile = profile;
  }

  String takeUserId() {
    return profile.userProfileId.toString();
  }

  String takeIsdCode() {
    return ARD_COMMON_DEFAULT_ISD_CODE;
  }

  String takePrimaryMobileIsdCode() {
    String isdCode = ARD_COMMON_DEFAULT_ISD_CODE;
    if (loggedIn && notBlankStr(profile.mobileCountryCode)) {
      isdCode = profile.mobileCountryCode.trim();
    }
    return isdCode;
  }

  String takeFullName() {
    String fullName = '';
    if (loggedIn &&
        (notBlankStr(profile.firstName) || notBlankStr(profile.lastName))) {
      fullName =
          notNullStr(profile.firstName) + ' ' + notNullStr(profile.lastName);
    }
    return fullName;
  }

  String takeMobileNo() {
    return loggedIn
        ? notNullStr(profile.mobileCountryCode) + notNullStr(profile.mobileNo)
        : '';
  }
}

@JsonSerializable()
class UserProfileFilter with CoreFilter {
  int userProfileId = -99;
  String mobileNo;
  String mobileCountryCode;
  String emailId;

  UserProfileFilter(
      {this.userProfileId,
      this.mobileNo,
      this.mobileCountryCode,
      this.emailId});

  factory UserProfileFilter.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFilterFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileFilterToJson(this);

  Map<String, String> toMap() {
    return {
      'userProfileId': userProfileId?.toString(),
      'mobileNo': mobileNo?.toString(),
      'mobileCountryCode': mobileCountryCode?.toString(),
      'emailId': emailId?.toString()
    };
  }
}

@JsonSerializable()
class UserProfileResponse extends CoreResponse {
  List<UserProfile> data = List();

  UserProfileResponse({bool status: false}) : super(status: status);

  UserProfile takeFirstData() {
    return null != data && data.length > 0 ? data[0] : null;
  }

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
