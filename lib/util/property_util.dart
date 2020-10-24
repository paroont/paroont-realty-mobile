import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:paroont_realty_mobile/model/property.dart';

import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/util/common_util.dart';
import 'package:intl/intl.dart';

String buildingTitle(PropertyDetail p) {
  return notBlankStr(p.builderName)
      ? '${p.builderName} ${p.buildingName}'
      : '${p.buildingName}';
}

String propertyArea(PropertyDetail p, int type) {
  String areaStr = '';

  double area = 0;
  int unitId = 0;
  int areaTypeId = 0;

  if (p.carpetArea > 0) {
    area = p.carpetArea;
    unitId = p.carpetAreaUnitId;
    areaTypeId = ARD_PROPERTY_AREA_TYPE_KEY_CARPET;
  } else if (p.builtUpArea > 0) {
    area = p.builtUpArea;
    unitId = p.builtUpAreaUnitId;
    areaTypeId = ARD_PROPERTY_AREA_TYPE_KEY_BUILT_UP;
  } else if (p.superBuiltUpArea > 0) {
    area = p.superBuiltUpArea;
    unitId = p.superBuiltUpAreaUnitId;
    areaTypeId = ARD_PROPERTY_AREA_TYPE_KEY_SUPER_BUILT_UP;
  }

  if (area > 0 && unitId > 0) {
    if (type == 1) {
      /*Sq Ft. */
      areaStr =
          '${unitAreaFormat().format(toSqFt(area, unitId))} ${RdmService().propertyAreaUnitTypeValue(ARD_PROPERTY_AREA_UNIT_KEY_SQ_FT)}';
    } else if (type == 2) {
      // Sq Mt.
      if (p.transactionTypeId == ARD_PROPERTY_TRANSACTION_TYPE_KEY_SELL) {
        areaStr =
            '(${unitAreaFormat().format(toSqMt(area, unitId))} ${RdmService().propertyAreaUnitTypeValue(ARD_PROPERTY_AREA_UNIT_KEY_SQ_MT)})';
      }
    } else if (type == 3) {
      // Type.
      areaStr = '${RdmService().propertyAreaTypeValue(areaTypeId)}';
    }
  }

//Rs. 2.1 Cr @ Rs.30,000/ sq. ft. | 788 sq. ft. (63.92 sq.m.) Carpet Area
  return areaStr;
}

NumberFormat propertyPriceFormat() {
  NumberFormat priceFormat = NumberFormat.compactCurrency(
      locale: 'en_IN', symbol: '\u20B9', decimalDigits: 2);
  priceFormat.minimumFractionDigits = 0;
  return priceFormat;
}

NumberFormat unitAreaFormat() {
  NumberFormat areaFormat = NumberFormat.decimalPattern();
  areaFormat.maximumFractionDigits = 2;
  areaFormat.minimumFractionDigits = 0;
  return areaFormat;
}

String propertyBuyAmount(PropertyDetail p) {
  String priceStr = '';
  if (p.transactionTypeId == ARD_PROPERTY_TRANSACTION_TYPE_KEY_SELL) {
    double price = p.expectedAmount;
    if (price > 0) {
      priceStr = '${propertyPriceFormat().format(price)}';
    }
  }
  return priceStr;
}

String propertyBuyUnitAmount(PropertyDetail p) {
  String priceStr = '';

  if (p.transactionTypeId == ARD_PROPERTY_TRANSACTION_TYPE_KEY_SELL) {
    double price = p.expectedAmount;
    double area = 0;
    int unitId = 0;
    if (price > 0) {
      if (p.carpetArea > 0) {
        area = p.carpetArea;
        unitId = p.carpetAreaUnitId;
      } else if (p.builtUpArea > 0) {
        area = p.builtUpArea;
        unitId = p.builtUpAreaUnitId;
      } else if (p.superBuiltUpArea > 0) {
        area = p.superBuiltUpArea;
        unitId = p.superBuiltUpAreaUnitId;
      }
      if (area > 0 && unitId > 0) {
        priceStr =
            ' @ ${propertyPriceFormat().format(price / area)} ${RdmService().propertyAreaUnitTypeValue(unitId)} ';
      }
    }
  }
  return priceStr;
}

String propertyRentAmount(PropertyDetail p) {
  String priceStr = '';
  if (p.transactionTypeId != ARD_PROPERTY_TRANSACTION_TYPE_KEY_SELL) {
    double rent = p.expectedRentAmount;
    if (rent > 0) {
      priceStr = '${propertyPriceFormat().format(rent)}/month ';
    }
  }
  return priceStr;
}

String propertyRentDepositAmount(PropertyDetail p) {
  String priceStr = '';
  if (p.transactionTypeId != ARD_PROPERTY_TRANSACTION_TYPE_KEY_SELL) {
    double deposit = p.expectedDepositAmount;

    if (deposit > 0) {
      priceStr = 'Deposit ${propertyPriceFormat().format(deposit)} ';
    }
  }
  return priceStr;
}

double toSqFt(double area, int areaUnitId) {
  double sqFt = 0;
  if (ARD_PROPERTY_AREA_UNIT_KEY_SQ_FT == areaUnitId) {
    sqFt = area;
  } else if (ARD_PROPERTY_AREA_UNIT_KEY_SQ_MT == areaUnitId) {
    sqFt = area * 10.763910417;
  }
  return sqFt;
}

double maxPropertyBudget(PropertyFilter filter) {
  List<int> ids = filter.transactionTypeIds;
  return ids.isEmpty || ids.contains(ARD_PROPERTY_TRANSACTION_TYPE_KEY_SELL)
      ? maxSellBudget()
      : maxRentBudget();
}

double minPropertyBudget(PropertyFilter filter) {
  return 0;
}

double maxUnitArea(PropertyFilter filter) {
  return 10000;
}

double minUnitArea(PropertyFilter filter) {
  return 0;
}


double maxSellBudget() {
  return 150000000;
}

double maxRentBudget() {
  return 1000000;
}

double toSqMt(double area, int areaUnitId) {
  double sqFt = 0;
  if (ARD_PROPERTY_AREA_UNIT_KEY_SQ_FT == areaUnitId) {
    sqFt = area / 10.763910417;
  } else if (ARD_PROPERTY_AREA_UNIT_KEY_SQ_MT == areaUnitId) {
    sqFt = area;
  }
  return sqFt;
}

List<String> propertySearchResultOutlines(PropertyDetail p) {
  final _outlines = List<String>();
  _addPropertyAvailableOutline(p, _outlines);
  _addPropertyAgeOutline(p, _outlines);

  _addFurnishOutline(p, _outlines);
  _addFloorNoOutline(p, _outlines);

  _addTenentTypeOutline(p, _outlines);

  _outlines.removeWhere((e) => isBlankStr(e));
  return _outlines;
}

void _addTenentTypeOutline(PropertyDetail p, List<String> outlines) {
  if (notNullInt(p.transactionTypeId) ==
          ARD_PROPERTY_TRANSACTION_TYPE_KEY_RENT ||
      notNullInt(p.transactionTypeId) == ARD_PROPERTY_TRANSACTION_TYPE_KEY_PG) {
    int key = notNullInt(p.tenantTypeId);
    if (key > 0) {
      outlines.add(RdmService().propertyPreferredTenantTypeValue(key));
    }
  }
}

void _addPropertyAgeOutline(PropertyDetail p, List<String> outlines) {
  int key = p.propertyAgeId;
  if (key > 0) {
    String value = RdmService().propertyAgeTypeValue(key);
    if (notBlankStr(value)) {
      outlines.add('Age $value');
    }
  }
}

void _addFurnishOutline(PropertyDetail p, List<String> outlines) {
  int key = p.furnishId;
  if (key > 0) {
    outlines.add(RdmService().propertyFurnishTypeValue(key));
  }
}

void _addPropertyAvailableOutline(PropertyDetail p, List<String> outlines) {
  int key = p.availabilityId;
  if (key > 0) {
    if (key == ARD_PROPERTY_AVAILABLE_TYPE_KEY_DATE &&
        null != p.availabilityTs) {
      String date = DateFormat(DF_DD_MMM_YYYY_SPACE).format(p.availabilityTs);
      outlines.add('Available from $date');
    } else {
      outlines.add(RdmService().propertyAvailableTypeValue(key));
    }
  }
}

void _addFloorNoOutline(PropertyDetail p, List<String> outlines) {
  int key = p.floorId;
  int tf = p.totalFloors;
  String value = '';
  if (key > 0) {
    if (key == ARD_FLOOR_NO_TYPE_KEY_NO) {
      String fno = p.floorNo;
      if (notBlankStr(fno)) {
        value = 'Floor $fno';
      }
    } else {
      value = RdmService().propertyFloorNoTypeValue(key);
      if (notBlankStr(value)) {
        value = '$value Floor';
      }
    }
    if (notBlankStr(value)) {
      if (tf > 0) {
        value = '$value of $tf';
      }
      outlines.add(value);
    }
  } else if (tf > 0) {
    outlines.add('Total Floor $tf');
  }
}


