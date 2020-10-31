// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile()
    ..statusId = json['statusId'] as int
    ..createdBy = json['createdBy'] as String
    ..createdTs = json['createdTs'] == null
        ? null
        : DateTime.parse(json['createdTs'] as String)
    ..updatedBy = json['updatedBy'] as String
    ..updatedTs = json['updatedTs'] == null
        ? null
        : DateTime.parse(json['updatedTs'] as String)
    ..userProfileId = json['userProfileId'] as int
    ..userId = json['userId'] as String
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..mobileNo = json['mobileNo'] as String
    ..mobileCountryCode = json['mobileCountryCode'] as String
    ..emailId = json['emailId'] as String
    ..emailId2 = json['emailId2'] as String
    ..emailId3 = json['emailId3'] as String
    ..profileTypeId = json['profileTypeId'] as int
    ..facebookId = json['facebookId'] as String
    ..twitterId = json['twitterId'] as String
    ..instagramId = json['instagramId'] as String
    ..whatsAppNo = json['whatsAppNo'] as String
    ..whatsAppCountryCode = json['whatsAppCountryCode'] as String
    ..contactNo2 = json['contactNo2'] as String
    ..contactNo2CountryCode = json['contactNo2CountryCode'] as String
    ..contactNo2Title = json['contactNo2Title'] as String
    ..contactNo3 = json['contactNo3'] as String
    ..contactNo3CountryCode = json['contactNo3CountryCode'] as String
    ..contactNo3Title = json['contactNo3Title'] as String
    ..addressLine1 = json['addressLine1'] as String
    ..addressLine2 = json['addressLine2'] as String
    ..cityId = json['cityId'] as String
    ..cityName = json['cityName'] as String
    ..stateId = json['stateId'] as String
    ..stateName = json['stateName'] as String
    ..landmarkId = json['landmarkId'] as String
    ..landmarkName = json['landmarkName'] as String
    ..pinCode = json['pinCode'] as String
    ..countryName = json['countryName'] as String
    ..genderTitle = json['genderTitle'] as String
    ..dob = json['dob'] == null ? null : DateTime.parse(json['dob'] as String)
    ..incomeRangeId = json['incomeRangeId'] as int
    ..companyName = json['companyName'] as String
    ..companyWebUrl = json['companyWebUrl'] as String
    ..companyOverview = json['companyOverview'] as String
    ..reraId = json['reraId'] as String;
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'statusId': instance.statusId,
      'createdBy': instance.createdBy,
      'createdTs': instance.createdTs?.toIso8601String(),
      'updatedBy': instance.updatedBy,
      'updatedTs': instance.updatedTs?.toIso8601String(),
      'userProfileId': instance.userProfileId,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNo': instance.mobileNo,
      'mobileCountryCode': instance.mobileCountryCode,
      'emailId': instance.emailId,
      'emailId2': instance.emailId2,
      'emailId3': instance.emailId3,
      'profileTypeId': instance.profileTypeId,
      'facebookId': instance.facebookId,
      'twitterId': instance.twitterId,
      'instagramId': instance.instagramId,
      'whatsAppNo': instance.whatsAppNo,
      'whatsAppCountryCode': instance.whatsAppCountryCode,
      'contactNo2': instance.contactNo2,
      'contactNo2CountryCode': instance.contactNo2CountryCode,
      'contactNo2Title': instance.contactNo2Title,
      'contactNo3': instance.contactNo3,
      'contactNo3CountryCode': instance.contactNo3CountryCode,
      'contactNo3Title': instance.contactNo3Title,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'cityId': instance.cityId,
      'cityName': instance.cityName,
      'stateId': instance.stateId,
      'stateName': instance.stateName,
      'landmarkId': instance.landmarkId,
      'landmarkName': instance.landmarkName,
      'pinCode': instance.pinCode,
      'countryName': instance.countryName,
      'genderTitle': instance.genderTitle,
      'dob': instance.dob?.toIso8601String(),
      'incomeRangeId': instance.incomeRangeId,
      'companyName': instance.companyName,
      'companyWebUrl': instance.companyWebUrl,
      'companyOverview': instance.companyOverview,
      'reraId': instance.reraId,
    };
