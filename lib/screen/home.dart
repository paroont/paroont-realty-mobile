import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/screen/property/search.dart';
import 'package:paroont_realty_mobile/screen/property/search_result.dart';
import 'package:paroont_realty_mobile/screen/property/my_property.dart';
import 'package:paroont_realty_mobile/screen/property/post_property_common.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedWidgetIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    PropertySearch(),
    MyPropertyWidget(),
    MyProfileWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Paroont")),
      body: Center(
        child: _widgetOptions.elementAt(_selectedWidgetIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            title: Text("Search"),
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            title: Text("My Property"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(Icons.account_circle),
          ),
        ],
        currentIndex: _selectedWidgetIndex,
        onTap: _selectWidget,
      ),
      /* drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("xyz"),
              accountEmail: Text("xyz@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("xyz"),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("abc"),
                )
              ],
            ),
            ListTile(
              title: new Text("All Inboxes"),
              leading: new Icon(Icons.mail),
            ),
            Divider(
              height: 0.1,
            ),
            ListTile(
              title: new Text("Primary"),
              leading: new Icon(Icons.inbox),
            ),
            ListTile(
              title: new Text("Social"),
              leading: new Icon(Icons.people),
            ),
            ListTile(
              title: new Text("Promotions"),
              leading: new Icon(Icons.local_offer),
            )
          ],
        ),
      ), */
    );
  }

  void _selectWidget(int index) {
    setState(() {
      _selectedWidgetIndex = index;
    });
  }
}

class PropertySearch extends StatefulWidget {
  @override
  _PropertySearchState createState() => _PropertySearchState();
}

class _PropertySearchState extends State<PropertySearch> {
  final searchResultState = GlobalKey<PropertySearchResultScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PropertySearchMainWidget(
        searchResultState: searchResultState,
        child: Column(
          children: [
            PropertySearchForm(),
            PropertySearchResultScreen(key: searchResultState),
          ],
        ),
      ),
      floatingActionButton: buildPostPropertyFloatingAction(context),
    );
  }
}

class MyProfileWidget extends StatefulWidget {
  @override
  _MyProfileWidgetState createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('My Profile.'),
    );
  }
}
