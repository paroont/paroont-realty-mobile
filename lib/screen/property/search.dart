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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter a property'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some property';
              }
              return null;
            },
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Searching...')));
              }
            },
            child: const Text('Filter', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
