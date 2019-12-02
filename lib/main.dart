import 'package:flutter/material.dart';
import 'package:flutter_currency/page/home_page.dart';
import 'package:flutter_currency/theme/theme.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kLightTheme,
      home: HomePage(),
    );
  }
}


