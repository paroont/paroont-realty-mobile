// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyDetail _$PropertyDetailFromJson(Map<String, dynamic> json) {
  return PropertyDetail()
    ..templateId = json['templateId'] as int
    ..projectName = json['projectName'] as String
    ..propertyTypeId = json['propertyTypeId'] as int
    ..propertyTypeTitle = json['propertyTypeTitle'] as String
    ..propertyTypeGroupId = json['propertyTypeGroupId'] as int
    ..propertyTypeGroupTitle = json['propertyTypeGroupTitle'] as String
    ..buildingName = json['buildingName'] as String
    ..builderName = json['builderName'] as String
    ..builderWebUrl = json['builderWebUrl'] as String
    ..availabilityId = json['availabilityId'] as int
    ..availabilityTitle = json['availabilityTitle'] as String
    ..availabilityTs = json['availabilityTs'] == null
        ? null
        : DateTime.parse(json['availabilityTs'] as String)
    ..propertyAgeId = json['propertyAgeId'] as int
    ..propertyAgeTitle = json['propertyAgeTitle'] as String
    ..localityIds = json['localityIds'] as String
    ..localityTitles = json['localityTitles'] as String
    ..addressLine1 = json['addressLine1'] as String
    ..addressLine2 = json['addressLine2'] as String
    ..cityName = json['cityName'] as String
    ..stateName = json['stateName'] as String
    ..landmarkName = json['landmarkName'] as String
    ..pinCode = json['pinCode'] as String
    ..countryName = json['countryName'] as String
    ..totalFloors = json['totalFloors'] as int
    ..totalFlatsFloor = json['totalFlatsFloor'] as int
    ..totalBuildingCoveredParking = json['totalBuildingCoveredParking'] as int
    ..totalBuildingOpenParking = json['totalBuildingOpenParking'] as int
    ..totalBuildingVisitorParking = json['totalBuildingVisitorParking'] as int
    ..totalServiceLift = json['totalServiceLift'] as int
    ..totalLift = json['totalLift'] as int
    ..reraId = json['reraId'] as String
    ..ocTs =
        json['ocTs'] == null ? null : DateTime.parse(json['ocTs'] as String)
    ..propertyDescription = json['propertyDescription'] as String
    ..earthquakeResistant = json['earthquakeResistant'] as int
    ..gasPipeline = json['gasPipeline'] as int
    ..clubHouse = json['clubHouse'] as int
    ..gym = json['gym'] as int
    ..kidsPlayArea = json['kidsPlayArea'] as int
    ..waterHarvesting = json['waterHarvesting'] as int
    ..swimmingPool = json['swimmingPool'] as int
    ..commonAreaPowerBackup = json['commonAreaPowerBackup'] as int
    ..flatPowerBackup = json['flatPowerBackup'] as int
    ..seniorCitizenArea = json['seniorCitizenArea'] as int
    ..gatedSociety = json['gatedSociety'] as int
    ..waterSupply = json['waterSupply'] as int
    ..landscapeLawn = json['landscapeLawn'] as int
    ..banquetHall = json['banquetHall'] as int
    ..joggersTrack = json['joggersTrack'] as int
    ..cctv = json['cctv'] as int
    ..fireAlarm = json['fireAlarm'] as int
    ..petFriendly = json['petFriendly'] as int
    ..propertyId = json['propertyId'] as int
    ..transactionTypeId = json['transactionTypeId'] as int
    ..transactionTypeTitle = json['transactionTypeTitle'] as String
    ..configurationId = json['configurationId'] as int
    ..configurationTitle = json['configurationTitle'] as String
    ..totalBedrooms = json['totalBedrooms'] as int
    ..totalMasterBedrooms = json['totalMasterBedrooms'] as int
    ..totalBathrooms = json['totalBathrooms'] as int
    ..totalBalconies = json['totalBalconies'] as int
    ..superBuiltUpArea = (json['superBuiltUpArea'] as num)?.toDouble()
    ..superBuiltUpAreaUnitId = json['superBuiltUpAreaUnitId'] as int
    ..superBuiltUpAreaUnitTitle = json['superBuiltUpAreaUnitTitle'] as String
    ..builtUpArea = (json['builtUpArea'] as num)?.toDouble()
    ..builtUpAreaUnitId = json['builtUpAreaUnitId'] as int
    ..builtUpAreaUnitTitle = json['builtUpAreaUnitTitle'] as String
    ..carpetArea = (json['carpetArea'] as num)?.toDouble()
    ..carpetAreaUnitId = json['carpetAreaUnitId'] as int
    ..carpetAreaUnitTitle = json['carpetAreaUnitTitle'] as String
    ..furnishId = json['furnishId'] as int
    ..furnishTitle = json['furnishTitle'] as String
    ..floorId = json['floorId'] as int
    ..floorNo = json['floorNo'] as String
    ..totalCoveredParking = json['totalCoveredParking'] as int
    ..totalOpenParking = json['totalOpenParking'] as int
    ..faceId = json['faceId'] as int
    ..faceTitle = json['faceTitle'] as String
    ..overlookIds = json['overlookIds'] as String
    ..overlookTitles = json['overlookTitles'] as String
    ..floorTypeIds = json['floorTypeIds'] as String
    ..floorTypeTitles = json['floorTypeTitles'] as String
    ..amountNegotiable = json['amountNegotiable'] as int
    ..maintenanceAmount = (json['maintenanceAmount'] as num)?.toDouble()
    ..maintenancePeriodId = json['maintenancePeriodId'] as int
    ..maintenancePeriodTitle = json['maintenancePeriodTitle'] as String
    ..modularKitchen = json['modularKitchen'] as int
    ..poojaRoom = json['poojaRoom'] as int
    ..studyRoom = json['studyRoom'] as int
    ..servantRoom = json['servantRoom'] as int
    ..othersRoom = json['othersRoom'] as int
    ..notes = json['notes'] as String
    ..totalBrokers = json['totalBrokers'] as int
    ..weekdaysVisitingIds = json['weekdaysVisitingIds'] as String
    ..weekdaysVisitingTitles = json['weekdaysVisitingTitles'] as String
    ..weekendVisitingIds = json['weekendVisitingIds'] as String
    ..weekendVisitingTitles = json['weekendVisitingTitles'] as String
    ..heavyDeposit = json['heavyDeposit'] as int
    ..expectedDepositAmount = (json['expectedDepositAmount'] as num)?.toDouble()
    ..expectedRentAmount = (json['expectedRentAmount'] as num)?.toDouble()
    ..expectedAmount = (json['expectedAmount'] as num)?.toDouble()
    ..allInclusiveAmount = json['allInclusiveAmount'] as int
    ..taxAndGovChargeIncluded = json['taxAndGovChargeIncluded'] as int;
}

Map<String, dynamic> _$PropertyDetailToJson(PropertyDetail instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'projectName': instance.projectName,
      'propertyTypeId': instance.propertyTypeId,
      'propertyTypeTitle': instance.propertyTypeTitle,
      'propertyTypeGroupId': instance.propertyTypeGroupId,
      'propertyTypeGroupTitle': instance.propertyTypeGroupTitle,
      'buildingName': instance.buildingName,
      'builderName': instance.builderName,
      'builderWebUrl': instance.builderWebUrl,
      'availabilityId': instance.availabilityId,
      'availabilityTitle': instance.availabilityTitle,
      'availabilityTs': instance.availabilityTs?.toIso8601String(),
      'propertyAgeId': instance.propertyAgeId,
      'propertyAgeTitle': instance.propertyAgeTitle,
      'localityIds': instance.localityIds,
      'localityTitles': instance.localityTitles,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'cityName': instance.cityName,
      'stateName': instance.stateName,
      'landmarkName': instance.landmarkName,
      'pinCode': instance.pinCode,
      'countryName': instance.countryName,
      'totalFloors': instance.totalFloors,
      'totalFlatsFloor': instance.totalFlatsFloor,
      'totalBuildingCoveredParking': instance.totalBuildingCoveredParking,
      'totalBuildingOpenParking': instance.totalBuildingOpenParking,
      'totalBuildingVisitorParking': instance.totalBuildingVisitorParking,
      'totalServiceLift': instance.totalServiceLift,
      'totalLift': instance.totalLift,
      'reraId': instance.reraId,
      'ocTs': instance.ocTs?.toIso8601String(),
      'propertyDescription': instance.propertyDescription,
      'earthquakeResistant': instance.earthquakeResistant,
      'gasPipeline': instance.gasPipeline,
      'clubHouse': instance.clubHouse,
      'gym': instance.gym,
      'kidsPlayArea': instance.kidsPlayArea,
      'waterHarvesting': instance.waterHarvesting,
      'swimmingPool': instance.swimmingPool,
      'commonAreaPowerBackup': instance.commonAreaPowerBackup,
      'flatPowerBackup': instance.flatPowerBackup,
      'seniorCitizenArea': instance.seniorCitizenArea,
      'gatedSociety': instance.gatedSociety,
      'waterSupply': instance.waterSupply,
      'landscapeLawn': instance.landscapeLawn,
      'banquetHall': instance.banquetHall,
      'joggersTrack': instance.joggersTrack,
      'cctv': instance.cctv,
      'fireAlarm': instance.fireAlarm,
      'petFriendly': instance.petFriendly,
      'propertyId': instance.propertyId,
      'transactionTypeId': instance.transactionTypeId,
      'transactionTypeTitle': instance.transactionTypeTitle,
      'configurationId': instance.configurationId,
      'configurationTitle': instance.configurationTitle,
      'totalBedrooms': instance.totalBedrooms,
      'totalMasterBedrooms': instance.totalMasterBedrooms,
      'totalBathrooms': instance.totalBathrooms,
      'totalBalconies': instance.totalBalconies,
      'superBuiltUpArea': instance.superBuiltUpArea,
      'superBuiltUpAreaUnitId': instance.superBuiltUpAreaUnitId,
      'superBuiltUpAreaUnitTitle': instance.superBuiltUpAreaUnitTitle,
      'builtUpArea': instance.builtUpArea,
      'builtUpAreaUnitId': instance.builtUpAreaUnitId,
      'builtUpAreaUnitTitle': instance.builtUpAreaUnitTitle,
      'carpetArea': instance.carpetArea,
      'carpetAreaUnitId': instance.carpetAreaUnitId,
      'carpetAreaUnitTitle': instance.carpetAreaUnitTitle,
      'furnishId': instance.furnishId,
      'furnishTitle': instance.furnishTitle,
      'floorId': instance.floorId,
      'floorNo': instance.floorNo,
      'totalCoveredParking': instance.totalCoveredParking,
      'totalOpenParking': instance.totalOpenParking,
      'faceId': instance.faceId,
      'faceTitle': instance.faceTitle,
      'overlookIds': instance.overlookIds,
      'overlookTitles': instance.overlookTitles,
      'floorTypeIds': instance.floorTypeIds,
      'floorTypeTitles': instance.floorTypeTitles,
      'amountNegotiable': instance.amountNegotiable,
      'maintenanceAmount': instance.maintenanceAmount,
      'maintenancePeriodId': instance.maintenancePeriodId,
      'maintenancePeriodTitle': instance.maintenancePeriodTitle,
      'modularKitchen': instance.modularKitchen,
      'poojaRoom': instance.poojaRoom,
      'studyRoom': instance.studyRoom,
      'servantRoom': instance.servantRoom,
      'othersRoom': instance.othersRoom,
      'notes': instance.notes,
      'totalBrokers': instance.totalBrokers,
      'weekdaysVisitingIds': instance.weekdaysVisitingIds,
      'weekdaysVisitingTitles': instance.weekdaysVisitingTitles,
      'weekendVisitingIds': instance.weekendVisitingIds,
      'weekendVisitingTitles': instance.weekendVisitingTitles,
      'heavyDeposit': instance.heavyDeposit,
      'expectedDepositAmount': instance.expectedDepositAmount,
      'expectedRentAmount': instance.expectedRentAmount,
      'expectedAmount': instance.expectedAmount,
      'allInclusiveAmount': instance.allInclusiveAmount,
      'taxAndGovChargeIncluded': instance.taxAndGovChargeIncluded,
    };
