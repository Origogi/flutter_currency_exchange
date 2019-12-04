import 'package:flutter/cupertino.dart';
import 'package:flutter_currency/model/currency.dart';

class CurrencyProvider extends ChangeNotifier {
  Currency _myCurrency = currencyBank[southKorea];

  Currency get selectedCurrency => _myCurrency;

  List<Currency> get comparedCurrencies => _getComparedCurrencies(_myCurrency);

  void updateMyCurrency (Currency currency) {
    _myCurrency = currency;
    notifyListeners();
  }

List<Currency> _getComparedCurrencies(Currency filtered) {
    return currencyBank.values
        .where((currency) => filtered != currency)
        .toList();
  }
}
