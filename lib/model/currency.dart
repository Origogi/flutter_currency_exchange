class Currency {
  String nationName;
  String imageFileName;
  String symbol;
  String code;

  Currency({this.nationName, this.imageFileName, this.symbol, this.code});
}

final southKorea = 'South Korea';
final eu = 'EU';
final usa = 'U.S.A.';
final japan = 'Japan';
final china = 'China';

var currencyBank = {
  southKorea: Currency(
      code: 'KRW',
      symbol: '₩',
      nationName: southKorea,
      imageFileName: 'assets/images/094-south-korea.png'),
  eu: Currency(
    code: 'EUR',
      symbol: '€',
      nationName: eu,
      imageFileName: 'assets/images/259-european-union.png'),
  usa: Currency(
      code: 'USD',
      symbol: "\$",
      nationName: usa,
      imageFileName: 'assets/images/000-united-states.png'),
  japan: Currency(
      code: 'JPY',
      symbol: '¥',
      nationName: japan,
      imageFileName: 'assets/images/063-japan.png'),
  china: Currency(
      symbol: '¥',
      code: 'CHY',
      nationName: china,
      imageFileName: 'assets/images/034-china.png'),
};
