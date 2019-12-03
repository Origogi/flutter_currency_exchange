import 'package:flutter/material.dart';
import 'package:flutter_currency/bloc/currency_bloc.dart';
import 'package:flutter_currency/page/home_page.dart';
import 'package:flutter_currency/theme/theme.dart';

import 'bloc/bloc_base.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: kLightTheme,
        home: BlocProvider<CurrencyBloc>(
          bloc: CurrencyBloc(),
          child: HomePage(),
        ));
  }
}
