import 'package:flutter/material.dart';

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

class PropertyInfoScreen extends StatelessWidget {
  final String propertyName;

  PropertyInfoScreen({Key key, @required this.propertyName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Details!"),
      ),
      body: Center(
        child: Text('$propertyName'),
      ),
    );
  }
}
