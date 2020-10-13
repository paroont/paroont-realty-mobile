import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/screen/property/search.dart';
import 'package:paroont_realty_mobile/screen/property/search_result.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final searchResultState = GlobalKey<PropertySearchResultScreenState>();
  final filter = new PropertyFilter();
  @override
  Widget build(BuildContext context) {
    return PropertySearchMainWidget(
        searchResultState: searchResultState,
        filter: filter,
        child: Column(
          children: [
            PropertySearchForm(),
            PropertySearchResultScreen(key: searchResultState),
          ],
        ),
        );
  }
}
