import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/screen/property/search.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Column(
      children: [
        PropertySearchForm(),
        //_buildSearchResults(),
      ],
    );
  }

  Widget _buildSearch() {
    return Row(children: [
      TextField(
        decoration: InputDecoration(
             hintText: 'Enter a search term'),
      )
    ]);
  }

  Widget _buildSearchResults() {
    return Container(
        child: ListView(
      children: [
        ListTile(title: Text("Property 1")),
        ListTile(title: Text("Property 2")),
        ListTile(title: Text("Property 3"))
      ],
    ));
  }
}
