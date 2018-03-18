import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new BottomNavigationState();
  }

}

class BottomNavigationState extends State<BottomNavigation>{
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new BottomNavigationItem('首页'),
          new BottomNavigationItem('关注'),
          new BottomNavigationItem('消息'),
          new BottomNavigationItem('我的'),
        ],
      ),
    );
  }

}

class BottomNavigationItem extends StatelessWidget{

  final String _text ;

  BottomNavigationItem(this._text);
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 50.0,
      height: 50.0,
      child: new Center(child: new Text(_text,style: new TextStyle(fontSize: 16.0, color: Colors.white,fontWeight: FontWeight.bold,),),),
    );
  }

}