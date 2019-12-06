import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_currency/model/currency.dart';
import 'package:flutter_currency/provider/currency_provider.dart';
import 'package:provider/provider.dart';

class ItemPickerPage extends StatelessWidget {

  List<Currency> _currencies;
  Function _itemSelectedFuction;

  ItemPickerPage(this._currencies, this._itemSelectedFuction);

  @override
  Widget build(BuildContext context) {
    final CurrencyProvider provider = Provider.of<CurrencyProvider>(context);

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
              itemCount: _currencies.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _itemSelectedFuction(context, _currencies[index]);
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
                                Image.asset(_currencies[index].imageFileName)),
                        title: Text(_currencies[index].nationName),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(_currencies[index].code),
                            Text(_currencies[index].symbol),
                          ],
                        )),
                  ),
                );
              })),
    );
  }
}
