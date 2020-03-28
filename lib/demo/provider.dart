import 'dart:collection';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: 'Flutter App',
  home: Scaffold(
    appBar: AppBar(
      title: Text('Flutter'),
    ),
    body: ProviderRoute(),
  ),
));

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({Key key, this.child, @required this.data}) : super(key: key, child: child);

  final Widget child;

  final T data;

  @override
  bool updateShouldNotify( InheritedProvider<T> oldWidget) {
    return true;
  }
}

Type _typeof<T>() => T;

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child
  }): super(key: key);

  final Widget child;
  final T data;

  /* static T of<T>(BuildContext context) {
    final type = _typeof<InheritedProvider<T>>();
    final provider = context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>;
    return provider.data;
  } */

  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
      ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
      : context.findAncestorWidgetOfExactType<InheritedProvider<T>>();
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {
      
    });
  }

  @override
  void initState() { 
    super.initState();
    widget.data.addListener(update);
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  void didUpdateWidget (ChangeNotifierProvider<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

class Item {
  Item(this.price, this.count);

  double price;
  int count;
}

class CartModal extends ChangeNotifier {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice => _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget {
  ProviderRoute({Key key}) : super(key: key);

  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModal>(
        data: CartModal(),
        child: Column(
          children: <Widget>[
            Consumer<CartModal>(
              builder: (context, cart)=> Text("总价: ${cart.totalPrice}")
            ),
            Builder(builder: (context) {
              print("RaisedButton build"); //在后面优化部分会用到
              return RaisedButton(
                child: Text('添加商品'),
                onPressed: () {
                  ChangeNotifierProvider.of<CartModal>(context, listen: false).add(Item(20.0, 1));
                },
              );
            })
          ],
        )
      ),
    );
  }
}

class Consumer<T> extends StatelessWidget {
  const Consumer({Key key, this.child, @required this.builder}) : assert(builder != null), super(key: key);

  final Widget child;

  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return child != null ? child : builder(
      context,
      ChangeNotifierProvider.of<T>(context) //自动获取Model
    );
  }
}