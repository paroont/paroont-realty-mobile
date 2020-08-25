import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';

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
                  //border: const OutlineInputBorder(),
                  hintText: 'Enter a property',
                  suffixIcon: Icon(Icons.search)),
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
    if(i.isEven){
      p.propertyTypeId = 1;
      p.propertyTypeGroupId = 1;
      p.configurationId = 2;
      p.cityName ='Kharghar';
    }else
    {
      p.propertyTypeId = 2;
      p.propertyTypeGroupId = 2;
      p.configurationId = 4;
      p.cityName ='Mira Road';
    }
    p.buildingName = 'Property $i';
    return p;
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: _properties.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${Rdm().propertyConfigTypeValue(_properties[i].configurationId)}' &
                     '${Rdm().propertyTypeGroupsValue(_properties[i].propertyTypeId)} ${Rdm().propertyTypeValue(_properties[i].propertyTypeGroupId)} in ${_properties[i].cityName}'),
                   Text('${_properties[i].buildingName}'),
                    Text('Address $i')
                   
                  ],
                ),
                //title: Text('${_properties[i]}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PropertySearchDetailScreen(
                              propertyDetail: _properties[i],
                            )),
                  );
                },
              );
            }));
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
