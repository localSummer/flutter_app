import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: 'Flutter App',
  theme: ThemeData(
    primaryColor: Colors.blue
  ),
  home: ClipTestRoute(),
));

class ClipTestRoute extends StatelessWidget {
  const ClipTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset('assets/images/avatar.jpg', width: 60.0,);
    return Scaffold(
      appBar: AppBar(
        title: Text('剪裁'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            avatar,
            ClipOval(child: avatar,),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: avatar,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,
                  child: avatar,
                ),
                Text("你好世界", style: TextStyle(color: Colors.green),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(//将溢出部分剪裁
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5,//宽度设为原来宽度一半
                    child: avatar,
                  ),
                ),
                Text("你好世界",style: TextStyle(color: Colors.green))
              ],
            ),
          ],
        ),
      ),
    );
  }
}