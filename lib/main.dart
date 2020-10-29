import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/screen/home.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';

Future<void> main() async {
  await RdmService().loadAllAppRefData();
  runApp(RealtyApp());
}

class RealtyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome ',
      theme: ThemeData(
        primaryColor: Colors.red,
        primaryColorLight: Colors.redAccent,
      ),
      home: HomeWidget(),
    );
  }
}

