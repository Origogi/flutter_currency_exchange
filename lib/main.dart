import 'package:flutter/material.dart';
import 'package:flutter_currency/page/home_page.dart';
import 'package:flutter_currency/provider/currency_provider.dart';
import 'package:flutter_currency/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CurrencyProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: kLightTheme,
        home: HomePage());
  }
}
