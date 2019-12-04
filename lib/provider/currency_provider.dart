import 'package:flutter/cupertino.dart';
import 'package:flutter_currency/model/currency.dart';

class CurrencyProvider extends ChangeNotifier {
  Currency _myCurrency = currencyBank[southKorea];
  List<Currency> _comparedCurrencies = [];

  Currency get selectedCurrency => _myCurrency;

  List<Currency> get comparedCurrencies => _comparedCurrencies;

  CurrencyProvider() {
    _myCurrency = currencyBank[southKorea];
    _comparedCurrencies = _getComparedCurrencies(_myCurrency);
  }

  void updateMyCurrency(Currency currency) {
    _myCurrency = currency;
    _comparedCurrencies = _getComparedCurrencies(_myCurrency);

    notifyListeners();
  }

  void sortComparedCurrencies() {
    _comparedCurrencies.sort((a, b) => a.nationName.compareTo(b.nationName));
    notifyListeners();
  }

  List<Currency> _getComparedCurrencies(Currency filtered) {
    return currencyBank.values
        .where((currency) => filtered != currency)
        .toList();
  }
}
