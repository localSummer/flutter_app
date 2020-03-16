import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());

Widget redBox = DecoratedBox(
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]]),
    borderRadius: BorderRadius.circular(3.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black54,
        offset: Offset(2.0, 2.0),
        blurRadius: 4.0
      )
    ]
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
    child: Text('login', style: TextStyle(color: Colors.white),),
  ),
);
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar')
        ),
        body: Container(
          margin: EdgeInsets.only(top: 50.0, left: 120.0),
          constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.red, Colors.orange],
              center: Alignment.center,
              radius: .98
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0
              )
            ]
          ),
          transform: Matrix4.rotationZ(.2),
          alignment: Alignment.center,
          child: Text('5.20', style: TextStyle(
            color: Colors.white, fontSize: 40.0
          ),),
        ),
      ),
    );
  }
}