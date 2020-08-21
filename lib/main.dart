import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/screen/home.dart';

void main() {
  runApp(RealtyApp());
}

class RealtyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome ',
      theme: ThemeData(primaryColor: Colors.red),
      home: Scaffold(
        appBar: AppBar(title: Text("Paroont")),
        body: HomeBody(),
        primary: true,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text("Search"),
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              title: Text("Add"),
              icon: Icon(Icons.add_box),
            ),
          ],
        ),
        drawer: Drawer(
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
),
      ),
    );
  }
}
