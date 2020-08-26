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
              color:  Theme.of(context).primaryColor,
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
  final _selectedIds = Set<int>();
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

      p.expectedAmount = 50000000.8;
      p.carpetArea = 500;
      p.carpetAreaUnitId = 1;
    } else {
      p.propertyTypeId = 2;
      p.propertyTypeGroupId = 2;
      p.configurationId = 4;
      p.transactionTypeId = 2;
      p.cityName = 'Mira Road';
      p.builderName = 'Paradise';
      p.buildingName = 'Sai World Empire';
      p.expectedRentAmount = 21000.66;
      p.superBuiltUpArea = 300;
      p.superBuiltUpAreaUnitId = 2;
    }
    if (i > 10) {
      p.buildingName = 'Property $i';
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
    final selected = _selectedIds.contains(p.propertyId);
    return ListTile(
        leading: IconButton(
          icon: Icon(
            selected ? Icons.check_box : Icons.check_box_outline_blank,
            color: selected ? Theme.of(context).primaryColor : null,
          ),
          onPressed: () {
            setState(() {
              if (selected) {
                _selectedIds.remove(p.propertyId);
              } else {
                _selectedIds.add(p.propertyId);
              }
            });
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${notNullStr(Rdm().propertyConfigTypeValue(p.configurationId))} '
                '${notNullStr(Rdm().propertyTypeGroupsValue(p.propertyTypeId))} '
                '${notNullStr(Rdm().propertyTypeValue(p.propertyTypeGroupId))} '
                'in ${notNullStr(p.cityName)}'),
            Text(
              '${p.buildingName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Text('${propertyPriceWithArea(p)}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PropertySearchDetailScreen(
                      propertyDetail: p,
                    )),
          );
        });
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
