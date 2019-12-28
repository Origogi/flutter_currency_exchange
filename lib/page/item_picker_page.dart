import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_currency/model/currency.dart';

class ItemPickerPage extends StatelessWidget {
  final List<Currency> _currencies;

  ItemPickerPage(this._currencies);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _currencies.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context, _currencies[index]);
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
                              child: Image.asset(
                                  _currencies[index].imageFileName)),
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
      ),
    );
  }
}
