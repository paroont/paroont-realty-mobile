import 'package:paroont_realty_mobile/model/common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserProfile with CoreObj {
  int userProfileId = 0;
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

  UserProfile();
  UserProfile.upid(this.userProfileId);

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

class RealtyUser {
  bool loggedIn = false;
  UserProfile profile = new UserProfile.upid(1);

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
}
