import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/screen/property/search.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/util/common_util.dart';
import 'package:paroont_realty_mobile/util/property_util.dart';
import 'package:paroont_realty_mobile/service/property.dart';

class PropertySearchResultScreen extends StatefulWidget {
  const PropertySearchResultScreen({
    Key key,
  }) : super(key: key);

  @override
  PropertySearchResultScreenState createState() =>
      PropertySearchResultScreenState();
}

class PropertySearchResultScreenState
    extends State<PropertySearchResultScreen> {
  Future<List<PropertyDetail>> _properties;

  @override
  void didChangeDependencies() {
    loadProperties();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<PropertyDetail>>(
          future: _properties,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, i) => Divider(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return _buildRow(context, snapshot.data[i]);
                      }));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          }),
    );
  }

  void loadData() {
    setState(() {
      loadProperties();
    });
  }

  void loadProperties() {
    _properties = PropertyService()
        .allProperties(PropertySearchMainWidget.of(context).filter);
  }

  Widget _buildRow(BuildContext context, PropertyDetail p) {
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
                      '${notNullStr(RdmService().propertyTransactionTypeValue(p.transactionTypeId))} ',
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
            text:
                TextSpan(style: DefaultTextStyle.of(context).style, children: [
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
            children: _buildOutlines(context, p),
            spacing: 2,
          ),
        ],
      ),
      subtitle: Row(
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
      ),
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

  List<Widget> _buildOutlines(BuildContext context, PropertyDetail p) {
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
        ),
      );
    });

    return chips;
  }
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
