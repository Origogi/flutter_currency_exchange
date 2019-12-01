import 'package:flutter/material.dart';
import 'package:flutter_currency/bloc/currency_bloc.dart';
import 'package:flutter_currency/theme/theme.dart';

import 'model/currency.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kLightTheme,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Currency _myCurrency = currencyBank[southKorea];
  // List<Currency> _currencies = [
  //   currencyBank[usa],
  //   currencyBank[japan],
  //   currencyBank[eu],
  //   currencyBank[china]
  // ];

  CurrencyBloc currencyBloc = new CurrencyBloc();

  AnimationController _animationController;

  bool selected = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: selected ? Curves.easeOutQuint : Curves.easeInQuint,
            width: double.infinity,
            height: selected ? 250.0 : 180.0,
            color: Colors.blue,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 15, top: 10),
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
                  height: 10,
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
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.show_chart,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Charts',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            leading:
                                Icon(Icons.compare_arrows, color: Colors.white),
                            title: Text('Calculater',
                                style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: Icon(Icons.settings, color: Colors.white),
                            title: Text('Settings',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[],
                    )
                  ],
                ),
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
                        StreamBuilder(
                          stream: currencyBloc.myCurrencyObservable,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            Currency myCurrency = snapshot.data;

                            return Row(
                              children: <Widget>[
                                Container(
                                    height: 50,
                                    width: 50,
                                    child:
                                        Image.asset(myCurrency.imageFileName)),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            );
                          },
                        ),
                        FloatingActionButton(
                          child: Icon(Icons.search),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: currencyBloc.myCurrencyObservable,
                  builder: (context, snapShot) {
                    if (!snapShot.hasData) {
                      return Container();
                    }
                    Currency myCurrency = snapShot.data;
                    List<Currency> currencies =
                        _getComparedCurrencies(myCurrency);

                    return Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: currencies.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
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
                                trailing:
                                    Text('${currencies[index].symbol} 5,198.2'),
                              ),
                            );
                          }),
                    );
                  },
                ),
              ],
            ),
          ),
          AnimatedContainer(
            margin: selected
                ? EdgeInsets.only(top: 250)
                : EdgeInsets.only(top: 180),
            width: double.infinity,
            height: double.infinity,
            color: selected ? Colors.black54 : Colors.transparent,
            duration: Duration(milliseconds: 500),
            curve: selected ? Curves.easeOutQuint : Curves.easeInQuint,
          )
        ]),
      ),
    );
  }

  List<Currency> _getComparedCurrencies(Currency filtered) {
    return currencyBank.values
        .where((currency) => filtered != currency)
        .toList();
  }
}
