import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Widget state manage',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ParentWidget(),
    ));

class ParentWidget extends StatefulWidget {
  @override
  createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxB extends StatelessWidget {
  // 父组件状态更新，子组件会重新创建
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxB({Key key, this.active, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => onChanged(!active),
        child: Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
                color: active ? Colors.lightGreen[700] : Colors.grey[600]),
            child: Center(
              child: Text(
                active ? 'Active' : 'Inactive',
                style: TextStyle(fontSize: 32.0, color: Colors.white),
              ),
            )),
      ),
    );
  }
}
