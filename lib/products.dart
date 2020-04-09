import 'package:woocommerce_api/woocommerce_api.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:delivery_app/state_model.dart';
import 'package:scoped_model/scoped_model.dart';


class ProductsPage extends StatefulWidget {
  
  @override
  _ProductsPageState createState() => new _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
            builder: (context, child, model)  {
return FutureBuilder(
        future: model.getProducts(),
        builder: (_, s){

          if(s.data == null){
            return Container(
              child: Center(
                child: Text("Loading..."),
              ),
            );
          }

          return ListView.builder(
            itemCount: s.data.length,
            itemBuilder: (_, index){
            
            /// create a list of products
            return Card(
              child: Column(
                children: <Widget>[
                   Container(
                padding: EdgeInsets.only(top: 1),
                width: 200,
                height: 200,
              child: Image.network(s.data[index]["images"][0]["src"])
          ),
          Text('${s.data[index]["name"]}'),
          Text("Всего за " + s.data[index]["price"] + " руб."),
          MaterialButton(
            color: Colors.orange,
            onPressed: () {
              model.addProductToCart(s.data[index]['id']);
              // print(s.data[index]);
            },
            child: Text('В корзину'),
          ),
                ],
              ),
            );
              // return ListTile(
              //   leading: CircleAvatar(
              //     child: Image.network(s.data[index]["images"][0]["src"]),
              //   ),
              //   title: Text(s.data[index]["name"]),
              //   subtitle: Text("Всего за " + s.data[index]["price"] + " руб."),
              // );

            }
          );
        },
      );
            }
    );
  }
}