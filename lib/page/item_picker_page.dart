import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_currency/model/currency.dart';
import 'package:flutter_currency/provider/currency_provider.dart';
import 'package:provider/provider.dart';

class ItemPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CurrencyProvider provider = Provider.of<CurrencyProvider>(context);

    List<Currency> currencies = provider.comparedCurrencies;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: () {
          Navigator.of(context).pop();
        },),
      ),
      body: Container(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    provider.updateMyCurrency(currencies[index]);
                    Navigator.pop(context);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                        leading: Container(
                            height: 50,
                            width: 50,
                            child:
                                Image.asset(currencies[index].imageFileName)),
                        title: Text(currencies[index].nationName),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(currencies[index].code),
                            Text(currencies[index].symbol),
                          ],
                        )),
                  ),
                );
              })),
    );
  }
}
