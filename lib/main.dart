import 'package:flutter/material.dart';

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
        appBar: AppBar(title: Text("Welcome to Flutter")),
        body: Center(child: Text('Welcome!')),
      ),
    );
  }
}
