import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/util/common_util.dart';
import 'package:paroont_realty_mobile/util/property_util.dart';
import 'package:paroont_realty_mobile/service/property.dart';




Widget buildPropertyTileTitle(BuildContext context, PropertyDetail pd) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text:
                  'Id: ${pd.propertyId} ${notNullStr(RdmService().propertyTransactionTypeValue(pd.transactionTypeId))} ',
            ),
            TextSpan(
                text:
                    '${notNullStr(RdmService().propertyConfigTypeValue(pd.configurationId))} ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    '${notNullStr(RdmService().propertyTypeGroupsValue(pd.propertyTypeId))} '),
            TextSpan(
                text:
                    '${notNullStr(RdmService().propertyTypeValue(pd.propertyTypeGroupId))} '),
            TextSpan(text: 'in ${notNullStr(pd.cityName)} '),
          ],
        ),
      ),
      RichText(
        text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
          TextSpan(
              text: '${buildingTitle(pd)}',
              style: TextStyle(fontWeight: FontWeight.w400)),
        ]),
      ),
      RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: '${propertyBuyAmount(pd)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '${propertyBuyUnitAmount(pd)}',
            ),
            TextSpan(
                text: '${propertyRentAmount(pd)}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: '${propertyRentDepositAmount(pd)}',
                style: TextStyle(fontWeight: FontWeight.w200)),
            TextSpan(text: '| ', style: TextStyle(fontWeight: FontWeight.w200)),
            TextSpan(
              text: '${propertyArea(pd, 1)} ',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: '${propertyArea(pd, 2)} ',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            TextSpan(
              text: '${propertyArea(pd, 3)} Area',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
      Wrap(
        children: buildPropertyResultOutlines(context, pd),
        spacing: 2,
      ),
    ],
  );
}


Widget buildPropertyTileSubTitle(BuildContext context, PropertyDetail pd) {
  return Row(
    children: [
      Text("Agent: "),
      Text("View Contact No: "),
      IconButton(
        icon: Icon(
          Icons.phone,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.message,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {},
      ),
    ],
  );
}
List<Widget> buildPropertyResultOutlines(
    BuildContext context, PropertyDetail p) {
  List<Widget> chips = List();

  propertySearchResultOutlines(p).forEach((e) {
    chips.add(
      Chip(
        label: Text(
          e,
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        padding: EdgeInsets.all(2),
        //labelPadding: EdgeInsets.all(4),
        //labelPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      ),
    );
  });

  return chips;
}

class PropertySearchDetailScreen extends StatelessWidget {
  final PropertyDetail propertyDetail;

  PropertySearchDetailScreen({Key key, @required this.propertyDetail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Details!"),
      ),
      body: Center(
        child: Text('${propertyDetail.buildingName}'),
      ),
    );
  }
}
