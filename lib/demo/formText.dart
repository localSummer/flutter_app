import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Form Widget',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _FocusTestRouteState createState() => _FocusTestRouteState();
}

class _FocusTestRouteState extends State<MyApp> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    super.initState();
    focusNode1.addListener(() {
      print(focusNode1.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Theme(
            data: Theme.of(context).copyWith(
                hintColor: Colors.grey[200], // 定义下划线颜色和文本颜色
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0))), // 覆盖提示文本样式
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'input 1',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  focusNode: focusNode1,
                ),
                TextField(
                  focusNode: focusNode2, //关联focusNode2
                  decoration: InputDecoration(labelText: "input 2"),
                ),
                Builder(builder: (context) {
                  return Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('移动焦点'),
                        onPressed: () {
                          if (focusScopeNode == null) {
                            focusScopeNode = FocusScope.of(context);
                          }
                          focusScopeNode.requestFocus(focusNode2);
                        },
                      ),
                      RaisedButton(
                        child: Text('隐藏键盘'),
                        onPressed: () {
                          focusNode1.unfocus();
                          focusNode2.unfocus();
                        },
                      )
                    ],
                  );
                })
              ],
            ),
          )),
    );
  }
}
