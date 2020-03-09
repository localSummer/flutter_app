import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: 'Form validte',
  theme: ThemeData(
    primarySwatch: Colors.blue
  ),
  home: FormTestRoute(),
));

class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form validate'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: '用户名',
                  hintText: '用户名或邮箱',
                  icon: Icon(Icons.person)
                ),
                validator: (v) {
                  // 返回的是错误信息
                  return v.trim().length > 0 ? null : '用户名不能为空';
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '您的登录密码',
                  icon: Icon(Icons.lock)
                ),
                obscureText: true,
                validator: (v) {
                  return v.trim().length > 5 ? null : '密码不能少于6位';
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text('登录'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          // 在这里不能通过此方式获取FormState，context 是 FormTestRoute 的 context，所以向根查找会找不到因为在他内部。
                          // 另外一种解决方式 是在Form内部使用 Builder 在内部截取context，接着向上查找可以找到FormState
                          // print(Form.of(context)); null
                          if ((_formKey.currentState as FormState).validate()) {
                            // 验证数据通过
                            print('${_unameController.text},${_pwdController.text}');
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}