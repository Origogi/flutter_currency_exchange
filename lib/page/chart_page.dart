import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/model/currency.dart';
import 'package:flutter_currency/provider/currency_provider.dart';
import 'package:provider/provider.dart';

import 'item_picker_page.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Currency myCurrency = currencyBank[southKorea];
  Currency otherCurrency = currencyBank[usa];

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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.blue,
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Currency Chart',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.arrow_drop_down),
                                    onPressed: () {
                                      _changeMyCurrency(context);
                                    },
                                  ),
                                  Container(
                                      width: 50,
                                      height: 50,
                                      child: Image.asset(
                                        myCurrency.imageFileName,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(myCurrency.code)
                                ],
                              ),
                              Icon(
                                Icons.compare_arrows,
                                size: 30,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(otherCurrency.code),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: 50,
                                      height: 50,
                                      child: Image.asset(
                                        otherCurrency.imageFileName,
                                      )),
                                  IconButton(
                                    icon: Icon(Icons.arrow_drop_down),
                                    onPressed: () {
                                      _changeOtherCurrency(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('${myCurrency.symbol} 1,000',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.blue)),
                              Text('${otherCurrency.symbol} 1,200',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.blue))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: LineChartSample2(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeMyCurrency(BuildContext context) async {
    final CurrencyProvider provider = Provider.of<CurrencyProvider>(context);

    List<Currency> currencies = [];
    currencies.addAll(provider.comparedCurrencies);
    currencies.add(provider.selectedCurrency);

    currencies.remove(myCurrency);

    Currency result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemPickerPage(currencies);
    }));

    if (result != null) {
      setState(() {
        myCurrency = result;
      });
    }
  }

  void _changeOtherCurrency(BuildContext context) async {
    final CurrencyProvider provider = Provider.of<CurrencyProvider>(context);

    List<Currency> currencies = [];
    currencies.addAll(provider.comparedCurrencies);
    currencies.add(provider.selectedCurrency);

    currencies.remove(otherCurrency);

    Currency result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemPickerPage(currencies);
    }));

    if (result != null) {
      setState(() {
        otherCurrency = result;
      });
    }
  }
}

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.20,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                // color: const Color(0xff232d37)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: FlatButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            // color: Color(0xff37434d),
            color: Colors.black26,
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            // color: Color(0xff37434d),
            color: Colors.transparent,

            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
              color: const Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          // border: Border.all(color: const Color(0xff37434d), width: 0.5)),
          border: Border.all(color: Colors.transparent)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
              color: const Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
