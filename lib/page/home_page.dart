import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_currency/bloc/bloc_base.dart';
import 'package:flutter_currency/bloc/currency_bloc.dart';
import 'package:flutter_currency/model/currency.dart';


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
    final CurrencyBloc currencyBloc = BlocProvider.of<CurrencyBloc>(context);
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
