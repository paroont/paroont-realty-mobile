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
    ..propertyTypeGroupId = json['propertyTypeGroupId'] as int
    ..buildingName = json['buildingName'] as String
    ..builderName = json['builderName'] as String
    ..builderWebUrl = json['builderWebUrl'] as String
    ..availabilityId = json['availabilityId'] as int
    ..availabilityTs = json['availabilityTs'] == null
        ? null
        : DateTime.parse(json['availabilityTs'] as String)
    ..propertyAgeId = json['propertyAgeId'] as int
    ..localityIds = json['localityIds'] as String
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
    ..configurationId = json['configurationId'] as int
    ..totalBedrooms = json['totalBedrooms'] as int
    ..totalMasterBedrooms = json['totalMasterBedrooms'] as int
    ..totalBathrooms = json['totalBathrooms'] as int
    ..totalBalconies = json['totalBalconies'] as int
    ..superBuiltUpArea = (json['superBuiltUpArea'] as num)?.toDouble()
    ..superBuiltUpAreaUnitId = json['superBuiltUpAreaUnitId'] as int
    ..builtUpArea = (json['builtUpArea'] as num)?.toDouble()
    ..builtUpAreaUnitId = json['builtUpAreaUnitId'] as int
    ..carpetArea = (json['carpetArea'] as num)?.toDouble()
    ..carpetAreaUnitId = json['carpetAreaUnitId'] as int
    ..furnishId = json['furnishId'] as int
    ..floorId = json['floorId'] as int
    ..floorNo = json['floorNo'] as String
    ..totalCoveredParking = json['totalCoveredParking'] as int
    ..totalOpenParking = json['totalOpenParking'] as int
    ..faceId = json['faceId'] as int
    ..overlookIds = json['overlookIds'] as String
    ..floorTypeIds = json['floorTypeIds'] as String
    ..amountNegotiable = json['amountNegotiable'] as int
    ..maintenanceAmount = (json['maintenanceAmount'] as num)?.toDouble()
    ..maintenancePeriodId = json['maintenancePeriodId'] as int
    ..modularKitchen = json['modularKitchen'] as int
    ..poojaRoom = json['poojaRoom'] as int
    ..studyRoom = json['studyRoom'] as int
    ..servantRoom = json['servantRoom'] as int
    ..othersRoom = json['othersRoom'] as int
    ..notes = json['notes'] as String
    ..totalBrokers = json['totalBrokers'] as int
    ..weekdaysVisitingIds = json['weekdaysVisitingIds'] as String
    ..weekendVisitingIds = json['weekendVisitingIds'] as String
    ..heavyDeposit = json['heavyDeposit'] as int
    ..expectedDepositAmount = (json['expectedDepositAmount'] as num)?.toDouble()
    ..expectedRentAmount = (json['expectedRentAmount'] as num)?.toDouble()
    ..tenantTypeId = json['tenantTypeId'] as int
    ..expectedAmount = (json['expectedAmount'] as num)?.toDouble()
    ..allInclusiveAmount = json['allInclusiveAmount'] as int
    ..taxAndGovChargeIncluded = json['taxAndGovChargeIncluded'] as int;
}

Map<String, dynamic> _$PropertyDetailToJson(PropertyDetail instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'projectName': instance.projectName,
      'propertyTypeId': instance.propertyTypeId,
      'propertyTypeGroupId': instance.propertyTypeGroupId,
      'buildingName': instance.buildingName,
      'builderName': instance.builderName,
      'builderWebUrl': instance.builderWebUrl,
      'availabilityId': instance.availabilityId,
      'availabilityTs': instance.availabilityTs?.toIso8601String(),
      'propertyAgeId': instance.propertyAgeId,
      'localityIds': instance.localityIds,
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
      'configurationId': instance.configurationId,
      'totalBedrooms': instance.totalBedrooms,
      'totalMasterBedrooms': instance.totalMasterBedrooms,
      'totalBathrooms': instance.totalBathrooms,
      'totalBalconies': instance.totalBalconies,
      'superBuiltUpArea': instance.superBuiltUpArea,
      'superBuiltUpAreaUnitId': instance.superBuiltUpAreaUnitId,
      'builtUpArea': instance.builtUpArea,
      'builtUpAreaUnitId': instance.builtUpAreaUnitId,
      'carpetArea': instance.carpetArea,
      'carpetAreaUnitId': instance.carpetAreaUnitId,
      'furnishId': instance.furnishId,
      'floorId': instance.floorId,
      'floorNo': instance.floorNo,
      'totalCoveredParking': instance.totalCoveredParking,
      'totalOpenParking': instance.totalOpenParking,
      'faceId': instance.faceId,
      'overlookIds': instance.overlookIds,
      'floorTypeIds': instance.floorTypeIds,
      'amountNegotiable': instance.amountNegotiable,
      'maintenanceAmount': instance.maintenanceAmount,
      'maintenancePeriodId': instance.maintenancePeriodId,
      'modularKitchen': instance.modularKitchen,
      'poojaRoom': instance.poojaRoom,
      'studyRoom': instance.studyRoom,
      'servantRoom': instance.servantRoom,
      'othersRoom': instance.othersRoom,
      'notes': instance.notes,
      'totalBrokers': instance.totalBrokers,
      'weekdaysVisitingIds': instance.weekdaysVisitingIds,
      'weekendVisitingIds': instance.weekendVisitingIds,
      'heavyDeposit': instance.heavyDeposit,
      'expectedDepositAmount': instance.expectedDepositAmount,
      'expectedRentAmount': instance.expectedRentAmount,
      'tenantTypeId': instance.tenantTypeId,
      'expectedAmount': instance.expectedAmount,
      'allInclusiveAmount': instance.allInclusiveAmount,
      'taxAndGovChargeIncluded': instance.taxAndGovChargeIncluded,
    };

PropertyFilter _$PropertyFilterFromJson(Map<String, dynamic> json) {
  return PropertyFilter()
    ..propertyTypeId = json['propertyTypeId'] as int
    ..transactionTypeId = json['transactionTypeId'] as int
    ..searchQuery = json['searchQuery'] as String
    ..minBudget = (json['minBudget'] as num)?.toDouble()
    ..maxBudget = (json['maxBudget'] as num)?.toDouble()
    ..configurationId = json['configurationId'] as int
    ..availabilityId = json['availabilityId'] as int
    ..availabilityTs = json['availabilityTs'] == null
        ? null
        : DateTime.parse(json['availabilityTs'] as String)
    ..cityName = json['cityName'] as String
    ..areaName = json['areaName'] as String
    ..pinCode = json['pinCode'] as String
    ..minArea = (json['minArea'] as num)?.toDouble()
    ..maxArea = (json['maxArea'] as num)?.toDouble()
    ..areaTypeId = json['areaTypeId'] as int
    ..areaUnitId = json['areaUnitId'] as int
    ..tenantTypeId = json['tenantTypeId'] as int
    ..minFloorNo = json['minFloorNo'] as int
    ..maxFloorNo = json['maxFloorNo'] as int
    ..floorId = json['floorId'] as int
    ..saleTypeId = json['saleTypeId'] as int
    ..faceId = json['faceId'] as int
    ..furnishId = json['furnishId'] as int
    ..postedUserTypeId = json['postedUserTypeId'] as int
    ..totalBathrooms = json['totalBathrooms'] as int
    ..propertyAgeId = json['propertyAgeId'] as int
    ..postedTs = json['postedTs'] == null
        ? null
        : DateTime.parse(json['postedTs'] as String)
    ..localityIds = json['localityIds'] as String;
}

Map<String, dynamic> _$PropertyFilterToJson(PropertyFilter instance) =>
    <String, dynamic>{
      'propertyTypeId': instance.propertyTypeId,
      'transactionTypeId': instance.transactionTypeId,
      'searchQuery': instance.searchQuery,
      'minBudget': instance.minBudget,
      'maxBudget': instance.maxBudget,
      'configurationId': instance.configurationId,
      'availabilityId': instance.availabilityId,
      'availabilityTs': instance.availabilityTs?.toIso8601String(),
      'cityName': instance.cityName,
      'areaName': instance.areaName,
      'pinCode': instance.pinCode,
      'minArea': instance.minArea,
      'maxArea': instance.maxArea,
      'areaTypeId': instance.areaTypeId,
      'areaUnitId': instance.areaUnitId,
      'tenantTypeId': instance.tenantTypeId,
      'minFloorNo': instance.minFloorNo,
      'maxFloorNo': instance.maxFloorNo,
      'floorId': instance.floorId,
      'saleTypeId': instance.saleTypeId,
      'faceId': instance.faceId,
      'furnishId': instance.furnishId,
      'postedUserTypeId': instance.postedUserTypeId,
      'totalBathrooms': instance.totalBathrooms,
      'propertyAgeId': instance.propertyAgeId,
      'postedTs': instance.postedTs?.toIso8601String(),
      'localityIds': instance.localityIds,
    };
