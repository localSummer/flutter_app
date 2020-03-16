import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: '滚动监听',
  home: Scaffold(
    appBar: AppBar(
      title: Text('滚动监听'),
    ),
    body: ScrollNotificationTestRoute(),
  ),
));

class ScrollNotificationTestRoute extends StatefulWidget {
  ScrollNotificationTestRoute({Key key}) : super(key: key);

  @override
  _ScrollNotificationTestRouteState createState() => _ScrollNotificationTestRouteState();
}

class _ScrollNotificationTestRouteState extends State<ScrollNotificationTestRoute> {
  String _progress = '0%';

  @override
  Widget build(BuildContext context) {
    return Container(
       child: NotificationListener<ScrollNotification>(
         onNotification: (ScrollNotification notification) {
           double progress = notification.metrics.pixels / notification.metrics.maxScrollExtent;
           setState(() {
             _progress = '${(progress * 100).toInt()}%';
           });
           print('Bottom Edge:${notification.metrics.extentAfter == 0}');
           return null;
         },
         child: Stack(
           alignment: Alignment.center,
           children: <Widget>[
             ListView.builder(
               itemCount: 100,
               itemExtent: 50.0,
               itemBuilder: (context, index) {
                 return ListTile(
                   title: Text('$index'),
                 );
               },
             ),
             CircleAvatar(
               child: Text(_progress),
               backgroundColor: Colors.black54,
             )
           ],
         ),
       ),
    );
  }
}
