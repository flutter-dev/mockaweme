import 'package:flutter/material.dart';
import 'package:mockaweme/pages/bottom_nav.dart';
import 'package:mockaweme/pages/home_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Stack(
          children: <Widget>[
            new Container(
              child: new HomePage(),
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new BottomNavigation(),
            ),
            new Align(
              alignment: Alignment.topLeft,
              child: new Image.asset(
                "images/r_.png",
                width: 10.0,
                height: 10.0,
              ),
            ),
            new Align(
              alignment: Alignment.topRight,
              child: new Image.asset(
                "images/ra.png",
                width: 10.0,
                height: 10.0,
              ),
            ),
            new Align(
              alignment: Alignment.bottomLeft,
              child: new Image.asset(
                "images/rb.png",
                width: 10.0,
                height: 10.0,
              ),
            ),
            new Align(
              alignment: Alignment.bottomRight,
              child: new Image.asset(
                "images/rc.png",
                width: 10.0,
                height: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
