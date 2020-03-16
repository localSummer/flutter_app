import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: 'Flutter App',
  home: Scaffold(
    appBar: AppBar(
      title: Text('Flutter'),
    ),
    body: WillPopScopeTestRoute(),
  ),
));

class WillPopScopeTestRoute extends StatefulWidget {
  WillPopScopeTestRoute({Key key}) : super(key: key);

  @override
  _WillPopScopeState createState() => _WillPopScopeState();
}

class _WillPopScopeState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt;
  @override
  Widget build(BuildContext context) {
    return Container(
       child: WillPopScope(
         onWillPop: () async {
           if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
             _lastPressedAt = DateTime.now();
             return false;
           }
           return true;
         },
         child: Container(
           alignment: Alignment.center,
           child: Text('1秒内连续按两次返回键退出'),
         ),
       ),
    );
  }
}