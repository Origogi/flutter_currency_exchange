import 'package:flutter_currency/model/currency.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyBloc {
  Currency _myCurrency = currencyBank[southKorea];
  BehaviorSubject<Currency> _myCurrencySubject;
  BehaviorSubject<List<Currency>> _comparedCurrenciesSubject;

  Observable<Currency> get myCurrencyObservable => _myCurrencySubject.stream;
  Observable<List<Currency>> get comparedCurrenciesObservable =>
      _comparedCurrenciesSubject.stream;

  CurrencyBloc() {
    _myCurrencySubject = BehaviorSubject<Currency>.seeded(_myCurrency);

    List<Currency> comparedCurrencies = _getComparedCurrencies(_myCurrency);

    _comparedCurrenciesSubject = BehaviorSubject.seeded(comparedCurrencies);
  }

  List<Currency> _getComparedCurrencies(Currency filtered) {
    return currencyBank.values
        .where((currency) => filtered != currency)
        .toList();
  }

  void dispose() {
    _myCurrencySubject.close();
    _comparedCurrenciesSubject.close();
  }
}
