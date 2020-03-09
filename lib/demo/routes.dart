import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 路由表集中配置使用较多
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute: '/',
      routes: {
        'new_page': (context) => TipRoute(text: ModalRoute.of(context).settings.arguments,),
        '/': (context) => RouterTestRoute()
      },
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            var result = await Navigator.pushNamed(context, 'new_page', arguments: 'hello flutter');
            print('路由返回值: $result');
          },
          child: Text('打开提示页'),
        ),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  final String text;

  TipRoute({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, '我是返回值');
                },
                child: Text('返回'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
