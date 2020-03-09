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
      child: TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxC({Key key, this.active, this.onChanged}): super(key: key);

  @override
  _TapboxCState createState() => new _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _handleTap,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
                border: _highlight ? Border.all(color: Colors.teal[700], width: 10.0) : null,
                color: widget.active ? Colors.lightGreen[700] : Colors.grey[600]),
            child: Center(
              child: Text(
                widget.active ? 'Active' : 'Inactive',
                style: TextStyle(fontSize: 32.0, color: Colors.white),
              ),
            )),
      ),
    );
  }
}
