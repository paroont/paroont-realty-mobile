import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/screen/property/search.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _properties = List<String>.generate(100, (i) => "Property $i");
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Column(
      children: [
        PropertySearchForm(),
        _buildProperties(),
      ],
    );
  }

  Widget _buildProperties() {
    return Expanded(
        child: ListView.builder(
            itemCount: _properties.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text('${_properties[i]}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PropertyInfoScreen(propertyName: _properties[i],)),
                  );
                },
              );
            }));
  }
}
