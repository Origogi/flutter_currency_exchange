import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_currency/model/currency.dart';
import 'package:flutter_currency/page/chart_page.dart';
import 'package:flutter_currency/page/item_picker_page.dart';
import 'package:flutter_currency/provider/currency_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  bool selected = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final CurrencyProvider provider = Provider.of<CurrencyProvider>(context);

    Currency myCurrency = provider.selectedCurrency;
    List<Currency> currencies = provider.comparedCurrencies;
    currencies.forEach((item) => print(item.nationName));

    return WillPopScope(
      onWillPop: () {
        if (selected) {
          setState(() {
            selected = false;
            _animationController.reverse();
          });
          return Future.value(false);
        } else {
          Navigator.pop(context);
          return Future.value(true);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _addCurrency(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomAppBar(context),
        body: SafeArea(
          child: Stack(children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: selected ? Curves.easeOutQuint : Curves.easeInQuint,
              width: double.infinity,
              height: selected ? 250.0 : 180.0,
              color: Colors.blue,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: AnimatedIcon(
                    size: 30,
                    icon: AnimatedIcons.menu_arrow,
                    progress: _animationController,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      selected = !selected;
                      if (selected) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 2,
                ),
                AnimatedContainer(
                  height: selected ? 200.0 : 0.0,
                  width: double.infinity,
                  duration: Duration(milliseconds: 500),
                  curve: selected ? Curves.easeOutQuint : Curves.easeInQuint,
                  child: AnimatedOpacity(
                    opacity: selected ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    curve: selected ? Curves.easeInQuint : Curves.easeOutQuint,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MenuItemWidget(Icons.show_chart, 'Charts'),
                            SizedBox(
                              height: 15,
                            ),
                            MenuItemWidget(Icons.compare_arrows, 'Calculator'),
                            SizedBox(
                              height: 15,
                            ),
                            MenuItemWidget(Icons.settings, 'Settings')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(15),
                    duration: Duration(milliseconds: 500),
                    curve: selected ? Curves.easeOutQuint : Curves.easeInQuint,
                    foregroundDecoration: BoxDecoration(
                      color: selected ? Colors.black54 : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Currency Calculate',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            myCurrency.imageFileName)),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          myCurrency.nationName,
                                          style: textTheme.title,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${myCurrency.symbol} 1,000',
                                          style: TextStyle(
                                              fontSize: 30, color: Colors.blue),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          '2019-11-11 WED 10:00 am',
                                          style: textTheme.body2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: () {
                                    _changeMyCurrency(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CurrencyListViewWidget(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    final CurrencyProvider provider = Provider.of<CurrencyProvider>(context);

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Theme.of(context).primaryColor,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.sort_by_alpha),
              onPressed: () {
                provider.sortComparedCurrencies();
              }),
        ],
      ),
    );
  }

  void _changeMyCurrency(BuildContext context) async {
    final CurrencyProvider provider = Provider.of<CurrencyProvider>(context);

    Currency result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemPickerPage(provider.comparedCurrencies);
    }));

    if (result != null) {
      provider.updateMyCurrency(result);
    }
  }

  void _addCurrency(BuildContext context) async {
    final CurrencyProvider provider = Provider.of<CurrencyProvider>(context);

    Currency result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemPickerPage(provider.notAddedCurrency);
    }));

    if (result != null) {
      provider.addCurrency(result);
    }
  }
}

class MenuItemWidget extends StatelessWidget {
  final IconData _icon;
  final String _title;

  MenuItemWidget(this._icon, this._title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChartPage();
        }));
      },
      child: Row(
        children: <Widget>[
          Icon(
            _icon,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            _title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class CurrencyListViewWidget extends StatefulWidget {
  CurrencyListViewWidget();

  @override
  _CurrencyListViewWidgetState createState() => _CurrencyListViewWidgetState();
}

class _CurrencyListViewWidgetState extends State<CurrencyListViewWidget> {
  _CurrencyListViewWidgetState();

  @override
  Widget build(BuildContext context) {
    final CurrencyProvider provider = Provider.of<CurrencyProvider>(context);

    List<Currency> currencies = provider.comparedCurrencies;

    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: currencies.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                provider.deleteCurrency(currencies[index]);
              },
              child: CurrencyItemWidget(currencies[index]));
        });
  }
}

class CurrencyItemWidget extends StatefulWidget {
  final Currency _currency;

  CurrencyItemWidget(this._currency);
  @override
  _CurrencyItemWidgetState createState() => _CurrencyItemWidgetState(_currency);
}

class _CurrencyItemWidgetState extends State<CurrencyItemWidget> {
  Currency _currency;

  _CurrencyItemWidgetState(this._currency);
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(_currency.imageFileName),
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_currency.nationName),
                          Text(
                            '1 ${_currency.code} = 1296 ${_currency.code}',
                            style: textTheme.body2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Text('${_currency.symbol} 5,198.2'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
