import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/screen/property/search.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PropertySearchForm(),
        PropertySearchResultScreen(),
      ],
    );
  }
}
