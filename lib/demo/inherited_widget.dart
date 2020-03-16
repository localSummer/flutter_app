import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: 'Flutter App',
  home: Scaffold(
    appBar: AppBar(
      title: Text('Flutter'),
    ),
    body: InheritedWidgetTestRoute(),
  ),
));

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({
    @required this.data,
    Widget child
  }) : super(child: child);

  final int data;

  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}


class _TestWidget extends StatefulWidget {
  _TestWidget({Key key}) : super(key: key);

  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text(
         ShareDataWidget.of(context).data.toString()
       ),
    );
  }

  @override
  void didChangeDependencies() {
    print('Dependencies change');
    super.didChangeDependencies();
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  InheritedWidgetTestRoute({Key key}) : super(key: key);

  @override
  _InheritedWidgetTestRouteState createState() => _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: _TestWidget(),
            ),
            RaisedButton(
              child: Text('Increment'),
              onPressed: () {
                setState(() {
                  ++count;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}