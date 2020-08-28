import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/util/common_util.dart';
import 'package:paroont_realty_mobile/util/property_util.dart';

class PropertySearchForm extends StatefulWidget {
  @override
  _PropertySearchFormState createState() => _PropertySearchFormState();
}

class _PropertySearchFormState extends State<PropertySearchForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter a property', suffixIcon: Icon(Icons.search)),
              autocorrect: true,
            ),
          ),
          IconButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Searching...')));
              }
            },
            iconSize: 45,
            icon: Icon(
              Icons.list,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class PropertySearchResultScreen extends StatefulWidget {
  @override
  _PropertySearchResultScreenState createState() =>
      _PropertySearchResultScreenState();
}

class _PropertySearchResultScreenState
    extends State<PropertySearchResultScreen> {
  final _properties = List<PropertyDetail>.generate(100, (i) {
    var p = PropertyDetail();
    p.propertyId = i;
    if (i.isEven) {
      p.propertyTypeId = 1;
      p.propertyTypeGroupId = 1;
      p.configurationId = 2;
      p.transactionTypeId = 1;
      p.cityName = 'Kharghar';
      p.builderName = 'Balaji';
      p.buildingName = 'Delta Central';

      p.expectedAmount = 10000000.8;
      p.carpetArea = 500;
      p.carpetAreaUnitId = 1;
      p.availabilityId = 1;
      p.furnishId = 1;
      p.propertyAgeId = 1;
      p.floorId = 1;
      p.floorNo = '4';
      p.totalFloors = 23;
    } else {
      p.propertyTypeId = 2;
      p.propertyTypeGroupId = 2;
      p.configurationId = 4;
      p.transactionTypeId = 2;
      p.cityName = 'Mira Road';
      p.builderName = 'Paradise';
      p.buildingName = 'Sai World Empire';
      p.expectedRentAmount = 21000.66;
      p.expectedDepositAmount = 125000;
      p.builtUpArea = 300;
      p.builtUpAreaUnitId = 2;
      p.availabilityId = 3;
      p.furnishId = 2;
      p.propertyAgeId = 2;
      p.tenantTypeId = 2;
      p.floorId = 1;
      p.floorNo = '5';
    }
    if (i > 6) {
      p.buildingName = 'Property $i';
      p.availabilityId = 2;
      p.floorId = 2;
      p.superBuiltUpArea = 600;
      p.superBuiltUpAreaUnitId = 2;
    }
    if (i > 8) {
      p.furnishId = 3;
      p.availabilityId = 4;
      p.availabilityTs = DateTime.now();
      p.floorId = 3;
    }
    return p;
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            separatorBuilder: (context, i) => Divider(),
            itemCount: _properties.length,
            itemBuilder: (context, i) {
              return _buildRow(context, _properties[i]);
            }));
  }

  Widget _buildRow(BuildContext context, PropertyDetail p) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text:
                  '${notNullStr(Rdm().propertyTransactionTypeValue(p.transactionTypeId))} ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text:
                        '${notNullStr(Rdm().propertyConfigTypeValue(p.configurationId))} ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        '${notNullStr(Rdm().propertyTypeGroupsValue(p.propertyTypeId))} '
                        '${notNullStr(Rdm().propertyTypeValue(p.propertyTypeGroupId))} '
                        'in ${notNullStr(p.cityName)} '),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
                text: '',
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                      text: '${buildingTitle(p)}',
                      style: TextStyle(fontWeight: FontWeight.w400)),
                ]),
          ),
          // Text('${buildingTitle(p)}'),
          RichText(
            text: TextSpan(
              text: '',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: '${propertyPrice(p)} | ',
                    style: TextStyle(fontWeight: FontWeight.w200)),
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
