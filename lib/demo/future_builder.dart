import 'package:flutter/material.dart';

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => '我是从互联网上获取的数据');
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}

void main(List<String> args) {
  return runApp(MaterialApp(
    title: 'FutureBuilder',
    home: Scaffold(
      appBar: AppBar(
        title: Text('FutureBuilder'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<String>(
              future: mockNetworkData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error:${snapshot.error}');
                  } else {
                    return Text('Contents:${snapshot.data}');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            StreamBuilder<int>(
              stream: counter(),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error:${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('没有Stream');
                    break;
                  case ConnectionState.waiting:
                    return Text('等待数据...');
                    break;
                  case ConnectionState.active:
                    return Text('active:${snapshot.data}');
                    break;
                  default:
                    return Text('Stream已关闭');
                    break;
                }
              },
            )
          ],
        )
      ),
    ),
  ));
}