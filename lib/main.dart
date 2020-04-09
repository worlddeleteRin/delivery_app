import 'package:flutter/material.dart';
import 'home.dart';
import 'package:delivery_app/state_model.dart';
import 'package:scoped_model/scoped_model.dart';


void main() {
  AppStateModel model = AppStateModel();
runApp(
    ScopedModel<AppStateModel>(
      model: model,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Мой электронный магазин'),
    );
  }
}

