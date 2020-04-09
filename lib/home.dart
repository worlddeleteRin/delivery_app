import 'package:woocommerce_api/woocommerce_api.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:delivery_app/state_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'products.dart';
import 'cart.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> products = [];
   AppStateModel model = AppStateModel();

  int _selectedIndex = 1;

  // GlobalKey bottomNavigationKey = GlobalKey();

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  widgetOptions(int page) {
    switch (page) {
      case 0:
      return ProductsPage();
      case 1: 
      return CartPage();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
            builder: (context, child, model)  {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: widgetOptions(_selectedIndex),
       bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          title: Text('Товары'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Корзина'),
        ),
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.green,
      backgroundColor: Colors.black87,
      onTap: _onItemTapped,
    ),
    );
            }
    );
  }
}