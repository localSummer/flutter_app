import 'package:flutter/material.dart';

void main(List<String> args) {
  return runApp(MaterialApp(
    title: 'Flutter StatefulWidget',
    home: CounterWidget(),
  ));
}

class CounterWidget extends StatefulWidget {
  final int initValue;

  const CounterWidget({Key key, this.initValue: 0}) : super(key: key);

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    print('initState');
  }

  Function handlePress(BuildContext context) => () {
    // ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
    // ScaffoldState _state = Scaffold.of(context); // 封装库常见这种格式，是对第一种方式的封装
    ScaffoldState _state = _globalKey.currentState;
    _state.showSnackBar(SnackBar(
      content: Text('我是Snackbar$_counter'),
    ));
    setState(() {
      ++_counter;
    });
  };

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('test StatefullWidget'),
      ),
      body: Center(child: Builder(
        builder: (context) {
          return RaisedButton(
            child: Text('$_counter',
                style: TextStyle(
                  fontSize: 26.0,
                )),
            onPressed: handlePress(context),
          );
        },
      )),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidge');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}
