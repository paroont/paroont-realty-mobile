import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:intl/intl.dart';

String propertyPriceWithArea(PropertyDetail p) {
  double price = 0;
  String priceStr = '';
  NumberFormat priceFormat = NumberFormat.compactCurrency(
      locale: 'en_IN', symbol: '\u20B9', decimalDigits: 2);
  priceFormat.minimumFractionDigits = 0;

  NumberFormat areaFormat = NumberFormat.decimalPattern();
  areaFormat.maximumFractionDigits = 2;
  areaFormat.minimumFractionDigits = 0;

  price = p.transactionTypeId == 1 ? p.expectedAmount : p.expectedRentAmount;
  if (price > 0) {
    priceStr = '${priceFormat.format(price)}';
    if (p.carpetArea > 0) {
      priceStr =
          '$priceStr ${_propertyAreaPrice(price, p.carpetArea, p.carpetAreaUnitId, 1, priceFormat, areaFormat)}';
    } else if (p.superBuiltUpArea > 0) {
      priceStr =
          '$priceStr ${_propertyAreaPrice(price, p.superBuiltUpArea, p.superBuiltUpAreaUnitId, 2, priceFormat, areaFormat)}';
    } else if (p.builtUpArea > 0) {
      priceStr =
          '$priceStr ${_propertyAreaPrice(price, p.builtUpArea, p.builtUpAreaUnitId, 3, priceFormat, areaFormat)}';
    }
  }
//Rs. 2.1 Cr @ Rs.30,000/ sq. ft. | 788 sq. ft. (63.92 sq.m.) Carpet Area
  return priceStr;
}

String _propertyAreaPrice(double price, double area, int areaUnitId,
    int areadUnitType, NumberFormat priceFormat, NumberFormat areaFormat) {
  String areaPrice = '@ ${priceFormat.format(price / area)}/';
  String areaUnitTitle = Rdm().propertyAreaUnitTypeValue(areaUnitId);

  areaPrice = '$areaPrice $areaUnitTitle';
  areaPrice =
      '$areaPrice | ${areaFormat.format(area)} $areaUnitTitle ${Rdm().propertyAreaTypeValue(areadUnitType)} Area';
  return areaPrice;
}
