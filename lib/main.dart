import 'package:flutter/material.dart';
import 'package:flutter_currency/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kLightTheme,
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            width: double.infinity,
            height: 180,
            color: Colors.blue,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
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
                        Row(
                          children: <Widget>[
                            Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                    'assets/images/094-south-korea.png')),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'South Korea',
                                  style: textTheme.body1,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  '￦ 1,000',
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
                        FloatingActionButton(
                          child: Icon(Icons.search),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                            'assets/images/259-european-union.png')),
                    title: Text('EU'),
                    subtitle: Text(
                      '1 EUR = 1296.1 KRW',
                      style: textTheme.body2,
                    ),
                    trailing: Text('€ 5,198.2'),
                  ),
                  
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                            'assets/images/259-european-union.png')),
                    title: Text('EU'),
                    subtitle: Text(
                      '1 EUR = 1296.1 KRW',
                      style: textTheme.body2,
                    ),
                    trailing: Text('€ 5,198.2'),
                  ),
                  
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                            'assets/images/259-european-union.png')),
                    title: Text('EU'),
                    subtitle: Text(
                      '1 EUR = 1296.1 KRW',
                      style: textTheme.body2,
                    ),
                    trailing: Text('€ 5,198.2'),
                  ),
                  
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    height: 50,
                    child: Center(
                      child : Icon(Icons.add,size: 20,)
                    ),
                  )
                  
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
