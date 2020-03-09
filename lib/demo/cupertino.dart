import 'package:flutter/cupertino.dart';

void main() => runApp(CupertinoApp(
      title: 'ios 风格组件',
      theme: CupertinoThemeData(primaryColor: CupertinoColors.activeBlue),
      home: CupertinoTestRoute(),
    ));

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Cupertino Demo'),
          backgroundColor: CupertinoColors.activeOrange,
        ),
        child: Center(
          child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text('Press'),
            onPressed: () {},
          ),
        ));
  }
}
