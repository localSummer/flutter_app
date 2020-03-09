import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: 'Widget state manage',
  theme: ThemeData(
    primarySwatch: Colors.blueGrey,
  ),
  home: TapboxA(),
));

class TapboxA extends StatefulWidget {
  TapboxA({Key key}): super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget state manage'),
        backgroundColor: Colors.brown,
      ),
      body: GestureDetector(
        onTap: _handleTap,
        child: Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600]
          ),
          child: Center(
            child: Text(_active ? 'Active' : 'Inactive', style: TextStyle(fontSize: 32.0, color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
