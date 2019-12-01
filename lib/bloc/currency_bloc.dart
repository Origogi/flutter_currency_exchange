import 'package:flutter_currency/model/currency.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyBloc {
  Currency _myCurrency = currencyBank[southKorea];
  BehaviorSubject<Currency> _myCurrencySubject;

  Observable<Currency> get myCurrencyObservable => _myCurrencySubject.stream;

  CurrencyBloc() {
    _myCurrencySubject = BehaviorSubject<Currency>.seeded(_myCurrency);
  }



  void dispose() {
    _myCurrencySubject.close();
  }
}
