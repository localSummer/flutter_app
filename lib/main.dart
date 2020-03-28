import 'package:flutter/material.dart';

void main(List<String> args) {
  return runApp(MaterialApp(
    title: 'Dialog State Manage',
    home: Scaffold(
      appBar: AppBar(
        title: Text('Dialog'),
      ),
      body: DialogRoute(),
    ),
  ));
}

class DialogRoute extends StatefulWidget {
  DialogRoute({Key key}) : super(key: key);

  @override
  _DialogRouteState createState() => _DialogRouteState();
}

class _DialogRouteState extends State<DialogRoute> {
  bool withTree = false;

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           RaisedButton(
             child: Text('打开对话框'),
             onPressed: () async {
              bool delete = await showDeleteConfirmDialog(context);
              if (delete == null) {
                print("取消删除");
              } else {
                print("同时删除子目录: $delete");
              }
             },
           )
         ],
       ),
    );
  }

  Future<bool> showDeleteConfirmDialog(BuildContext context) {
    withTree = false;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('您确定要删除当前文件吗?'),
              Row(
                children: <Widget>[
                  Text('同时删除子目录'),
                  StatefulBuilder(
                    builder: (context, _setState) {
                      return Checkbox(
                        value: withTree,
                        onChanged: (bool value) => {
                          _setState(() {
                            withTree = !withTree;
                          })
                        },
                      );
                    },
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //执行删除操作
                Navigator.of(context).pop(withTree);
              },
            ),
          ],
        );
      }
    );
  }
}