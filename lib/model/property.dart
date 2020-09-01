import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

@JsonSerializable()
class PropertyDetail {
  int templateId;
  String projectName;

  int propertyTypeId;

  int propertyTypeGroupId;

  String buildingName;
  String builderName;
  String builderWebUrl;

  int availabilityId;
  DateTime availabilityTs;

  int propertyAgeId = -1;

  String localityIds;

  String addressLine1;
  String addressLine2;
  String cityName;
  String stateName;
  String landmarkName;
  String pinCode;
  String countryName;

  int totalFloors = -1;
  int totalFlatsFloor = -1;

  int totalBuildingCoveredParking = -1;
  int totalBuildingOpenParking = -1;
  int totalBuildingVisitorParking = -1;

  int totalServiceLift = -1;
  int totalLift = -1;

  String reraId;

  DateTime ocTs;
  String propertyDescription;

  int earthquakeResistant = -1;
  int gasPipeline = -1;
  int clubHouse = -1;
  int gym = -1;
  int kidsPlayArea = -1;
  int waterHarvesting = -1;
  int swimmingPool = -1;
  int commonAreaPowerBackup = -1;
  int flatPowerBackup = -1;
  int seniorCitizenArea = -1;
  int gatedSociety = -1;
  int waterSupply = -1;
  int landscapeLawn = -1;
  int banquetHall = -1;
  int joggersTrack = -1;
  int cctv = -1;
  int fireAlarm = -1;

  int petFriendly = -1;
  int propertyId;
  int transactionTypeId;

  int configurationId;

  int totalBedrooms = -1;
  int totalMasterBedrooms = -1;
  int totalBathrooms = -1;
  int totalBalconies = -1;

  double superBuiltUpArea = -1;
  int superBuiltUpAreaUnitId = -1;

  double builtUpArea = -1;
  int builtUpAreaUnitId = -1;

  double carpetArea = -1;
  int carpetAreaUnitId = -1;

  int furnishId = -1;

  int floorId = -1;
  String floorNo;

  int totalCoveredParking = -1;
  int totalOpenParking = -1;

  int faceId = -1;

  String overlookIds;

  String floorTypeIds;

  int amountNegotiable = -1;
  double maintenanceAmount = -1;
  int maintenancePeriodId = -1;

  int modularKitchen = -1;

  int poojaRoom = -1;
  int studyRoom = -1;
  int servantRoom = -1;
  int othersRoom = -1;

  String notes;

  int totalBrokers = -1;

  String weekdaysVisitingIds;

  String weekendVisitingIds;

  int heavyDeposit = -1;
  double expectedDepositAmount = -1;
  double expectedRentAmount = -1;

  int tenantTypeId = -1;

  double expectedAmount = -1;

  int allInclusiveAmount = -1;
  int taxAndGovChargeIncluded = -1;

  PropertyDetail();

  factory PropertyDetail.fromJson(Map<String, dynamic> json) =>
      _$PropertyDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDetailToJson(this);
}
