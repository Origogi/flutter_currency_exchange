import 'package:flutter/cupertino.dart';
import 'package:flutter_currency/model/currency.dart';

class CurrencyProvider extends ChangeNotifier {
  Currency _myCurrency = currencyBank[southKorea];
  List<Currency> _comparedCurrencies = [
    currencyBank[southKorea],
    currencyBank[eu],
    currencyBank[china],
    currencyBank[japan],
    currencyBank[usa],
  ];

  List<Currency> get notAddedCurrency {
    return currencyBank.values.toSet().difference(_comparedCurrencies.toSet()).toList();
  }

  Currency get selectedCurrency => _myCurrency;

  List<Currency> get comparedCurrencies => _getComparedCurrencies(_myCurrency);

  CurrencyProvider() {
    _myCurrency = currencyBank[southKorea];
  }

  void updateMyCurrency(Currency currency) {
    _myCurrency = currency;

    notifyListeners();
  }

   void addCurrency(Currency currency) {
    _comparedCurrencies.add(currency);
    notifyListeners();
  }

  void sortComparedCurrencies() {
    _comparedCurrencies.sort((a, b) => a.nationName.compareTo(b.nationName));
    notifyListeners();
  }

  List<Currency> _getComparedCurrencies(Currency filtered) {
    return _comparedCurrencies
        .where((currency) => filtered != currency)
        .toList();
  }
}
