import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/util/common_util.dart';
import 'package:paroont_realty_mobile/util/property_util.dart';
import 'package:paroont_realty_mobile/service/property.dart';

Widget buildPropertyResultRow(
    BuildContext context, PropertyDetail p, bool includeSubTitle) {
  return ListTile(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text:
                    'Id: ${p.propertyId} ${notNullStr(RdmService().propertyTransactionTypeValue(p.transactionTypeId))} ',
              ),
              TextSpan(
                  text:
                      '${notNullStr(RdmService().propertyConfigTypeValue(p.configurationId))} ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      '${notNullStr(RdmService().propertyTypeGroupsValue(p.propertyTypeId))} '),
              TextSpan(
                  text:
                      '${notNullStr(RdmService().propertyTypeValue(p.propertyTypeGroupId))} '),
              TextSpan(text: 'in ${notNullStr(p.cityName)} '),
            ],
          ),
        ),
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
                text: '${buildingTitle(p)}',
                style: TextStyle(fontWeight: FontWeight.w400)),
          ]),
        ),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: '${propertyBuyAmount(p)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '${propertyBuyUnitAmount(p)}',
              ),
              TextSpan(
                  text: '${propertyRentAmount(p)}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '${propertyRentDepositAmount(p)}',
                  style: TextStyle(fontWeight: FontWeight.w200)),
              TextSpan(
                  text: '| ', style: TextStyle(fontWeight: FontWeight.w200)),
              TextSpan(
                text: '${propertyArea(p, 1)} ',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: '${propertyArea(p, 2)} ',
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
              TextSpan(
                text: '${propertyArea(p, 3)} Area',
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ),
        Wrap(
          children: buildPropertyResultOutlines(context, p),
          spacing: 2,
        ),
      ],
    ),
    subtitle: includeSubTitle
        ? Row(
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
          )
        : null,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PropertySearchDetailScreen(
                  propertyDetail: p,
                )),
      );
    },
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
