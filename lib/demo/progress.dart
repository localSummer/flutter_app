import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Progress bar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Progress bar'),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              children: <Widget>[
                LinearProgressIndicator(
                  value: 0.5, // 没有该值则执行循环动画
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: .5,
                ),
                SizedBox(
                  height: 100.0,
                  width: 130.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: .7,
                  ),
                ),
                SingleChildScrollView(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: ColorTween(
                      begin: Colors.grey,
                      end: Colors.blue
                    ).animate(_animationController),
                    value: .6,
                  ),
                )
              ],
            )));
  }
}
