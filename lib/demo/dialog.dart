import 'package:flutter/material.dart';

void main(List<String> args) {
  return runApp(MaterialApp(
    title: 'Flutter Dialog',
    home: Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: Text('Dialog'),
        ),
      ),
      body: AlertDialogTest(),
    ),
  ));
}

class AlertDialogTest extends StatelessWidget {
  const AlertDialogTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('alert dialog'),
            onPressed: () async {
              bool delete = await showDeleteConfirmDialog1(context);
              if (delete == null) {
                print('取消删除');
              } else {
                print('已确认删除');
              }
            },
          ),
          RaisedButton(
            child: Text('simple dialog'),
            onPressed: () => changeLanguage(context),
          ),
          RaisedButton(onPressed: () => showListDialog(context), child: Text('List dialog')),
          RaisedButton(
            child: Text('custom dialog'),
            onPressed: () => showCustomDialogTest(context),
          )
        ],
      )
    );
  }
}

Future<bool> showDeleteConfirmDialog1(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('提示'),
        content: Text("您确定要删除当前文件吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              //关闭对话框并返回true
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    }
  );
}

Future<void> changeLanguage(BuildContext context) async {
  int i = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('请选择语言'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 1);
            },
            child: Padding(padding: EdgeInsets.symmetric(vertical: 6), child: Text('中文简体'),),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 2),
            child: Padding(padding: EdgeInsets.symmetric(vertical: 6), child: Text('英语'),),
          )
        ],
      );
    }
  );
  if (i != null) {
    print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
  }
}

Future<void> showListDialog(BuildContext context) async {
  int index = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      Widget child = Column(
        children: <Widget>[
          ListTile(title: Text('请选择'),),
          Expanded(child: ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('$index'),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          ))
        ],
      );
      return Dialog(
        child: child,
      );
    }
  );
  if (index != null) {
    print("点击了：$index");
  }
}

Future<T> showCustomDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(child: Builder(builder: (BuildContext context) {
        return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
      }));
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87,
    transitionDuration: const Duration(microseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions
  );
}

Widget _buildMaterialDialogTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child
) {
  return ScaleTransition(
    scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
    child: child,
  );
}

Future<void> showCustomDialogTest(BuildContext context) async {
  bool delete = await showCustomDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Text("您确定要删除当前文件吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              // 执行删除操作
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    }
  );
  if (delete != null) {
    print(delete);
  }
}