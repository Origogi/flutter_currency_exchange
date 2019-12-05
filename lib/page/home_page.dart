import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_currency/model/currency.dart';
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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
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
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              child: Column(
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
                      curve:
                          selected ? Curves.easeInQuint : Curves.easeOutQuint,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              MenuItem(Icons.show_chart, 'Charts'),
                              SizedBox(
                                height: 15,
                              ),
                              MenuItem(Icons.compare_arrows, 'Calculator'),
                              SizedBox(
                                height: 15,
                              ),
                              MenuItem(Icons.settings, 'Settings')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    padding: EdgeInsets.all(15),
                    duration: Duration(milliseconds: 500),
                    curve: selected ? Curves.easeOutQuint : Curves.easeInQuint,
                    foregroundDecoration: BoxDecoration(
                      color: selected ? Colors.black54 : Colors.transparent,
                    ),
                    child: Column(
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
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ItemPickerPage();
                                    }));
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: currencies.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onLongPress: () {
                                  print('long press');
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            currencies[index].imageFileName)),
                                    title: Text(currencies[index].nationName),
                                    subtitle: Text(
                                      '1 ${currencies[index].code} = 1296 ${myCurrency.code}',
                                      style: textTheme.body2,
                                    ),
                                    trailing: Text(
                                        '${currencies[index].symbol} 5,198.2'),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // AnimatedContainer(
          //   margin: selected
          //       ? EdgeInsets.only(top: 250)
          //       : EdgeInsets.only(top: 180),
          //   width: double.infinity,
          //   height: double.infinity,
          //   color: selected ? Colors.black54 : Colors.transparent,
          //   duration: Duration(milliseconds: 500),
          //   curve: selected ? Curves.easeOutQuint : Curves.easeInQuint,
          // )
        ]),
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
}

class MenuItem extends StatelessWidget {
  IconData _icon;
  String _title;

  MenuItem(this._icon, this._title);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
