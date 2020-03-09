import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Widget state manage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BaseWidget(),
    ));

class BaseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Base Widget'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        width: 300.0,
        height: 1600.0,
        padding: EdgeInsets.all(30.0),
        child: ListView(
          children: <Widget>[
            Text('Text Widget'*4, textAlign: TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis, textScaleFactor: 1.5,),
            Text('Text Widget'*4, style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              height: 1.2, // 行高1.2
              fontFamily: 'Courier',
              background: Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed
            ),),
            Text.rich(TextSpan(
              children: [
                TextSpan(text: 'Home:'),
                TextSpan(text: 'https://flutterchina.club', style: TextStyle(color: Colors.blue))
              ]
            )),
            DefaultTextStyle(style: TextStyle(
              color: Colors.red,
              fontSize: 20.0
            ), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Hello Flutter'),
                Text('Hello dart'),
                Text('I\'m learning Flutter', style: TextStyle(
                  inherit: false,
                  color: Colors.grey // 不继承默认样式，则该组件样式完全隔离
                ),)
              ],
            ), textAlign: TextAlign.left,),
            RaisedButton(
              child: Text('normal'),
              onPressed: () {},
            ),
            FlatButton(onPressed: () {}, child: Text('normal')), // onPressed置为皆为null或者没有设置该选项，则按钮为禁用状态
            OutlineButton(onPressed: () {}, child: Text('normal'),),
            IconButton(icon: Icon(Icons.thumb_up), onPressed: () {}),
            RaisedButton.icon(onPressed: () {}, icon: Icon(Icons.send), label: Text('发送')),
            OutlineButton.icon(onPressed: () {}, icon: Icon(Icons.add), label: Text('添加')),
            FlatButton.icon(onPressed: () {}, icon: Icon(Icons.info), label: Text('详情')),
            RaisedButton(onPressed: () {}, child: Text('Submit'), color: Colors.blue, highlightColor: Colors.blue[700], colorBrightness: Brightness.dark, splashColor: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
            Image(image: AssetImage('assets/images/avatar.jpg'), width: 150.0, height: 150.0, fit: BoxFit.contain,),
            Image.asset('assets/images/avatar.jpg', alignment: Alignment.topLeft, repeat: ImageRepeat.repeatX,),
            Image(image: NetworkImage('https://avatars2.githubusercontent.com/u/20411648?s=460&v=4'), width: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.accessible, color: Colors.green,),
                Icon(Icons.error, color: Colors.green,),
                Icon(Icons.fingerprint, color: Colors.green,),
                Icon(MyIcons.arrowRight, color: Colors.purple,),
                Icon(MyIcons.playFill, color: Colors.green, size: 30.0,)
              ],
            ),
            SwitchAndCheckboxTestRoute()
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.lightGreen, width: 3.0)
        ),
      )
    );
  }
}

// 字体图标的代码可在下载的iconfont demo 找到
class MyIcons {
  static const IconData arrowRight = const IconData(
    0xe743,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );

  static const IconData playFill = const IconData(
    0xe72f,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );
}

// switch and checkbox 状态在父组件中保存
class SwitchAndCheckboxTestRoute extends StatefulWidget {
  @override
  _SwitchAndCheckboxTestRouteState createState() => _SwitchAndCheckboxTestRouteState();
}

class _SwitchAndCheckboxTestRouteState extends State<SwitchAndCheckboxTestRoute> {
  bool _switchSelected = true;
  bool _checkboxSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(value: _switchSelected, onChanged: (value) {
          setState(() {
            _switchSelected = value;
          });
        }),
        Checkbox(value: _checkboxSelected, activeColor: Colors.red, tristate: true, onChanged: (value) {
          setState(() {
            _checkboxSelected = value;
          });
        })
      ],
    );
  }
}
