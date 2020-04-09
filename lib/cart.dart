import 'package:woocommerce_api/woocommerce_api.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:delivery_app/state_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'products.dart';
import 'home.dart';

class CartPage extends StatefulWidget {
  
  @override
  _CartPageState createState() => new _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List allproducts;

  List<Widget> _createShoppingCartRows(AppStateModel model) {
    return model.productsInCart.keys
        .map(
          (id) =>  
          ShoppingCartRow(
            id,
            allproducts,
            quantity: model.productsInCart[allproducts.firstWhere((p) => p['id'] == id)['id']],
            addquantity: () {
              model.addProductToCart(allproducts.firstWhere((p) => p['id'] == id)['id']);
            },
            removequantity: () {
              model.removeItemFromCart(allproducts.firstWhere((p) => p['id'] == id)['id']);
            },
          )
        )
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
            builder: (context, child, model) {
              allproducts = model.allproducts;
              print(allproducts);
              return Stack(
                children: [
                  ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 30, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            'Ваши покупки',
                          ),
                          const SizedBox(width: 16.0),
                          Text('Товаров: ${model.totalCartQuantity}'),
                        ],
                      ),
                      ),
                      const SizedBox(height: 16.0),
                      Column(
                        children: _createShoppingCartRows(model),
                      ),
                      // ShoppingCartSummary(model: model),
                      const SizedBox(height: 100.0),
                    ],
                  ),
                  Positioned(
                    bottom: 15.0,
                    left: 16.0,
                    right: 16.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            //showAlertDialog();
                            if(model.totalCartQuantity == 0) {
                              return showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Корзина пуста'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('Ваша корзина пуста.'),
                                        Text('Добавьте товар, чтобы сделать заказ!'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      // color: Colors.orange,
                                      child: Text('Продолжить',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                              );
                            } else {
                            Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                            }
                        //model.clearCart();
                        //ExpandingBottomSheet.of(context).close();
                          },
                          height: 50,
                          minWidth: 200,
                          elevation: 10,
                          color: Colors.green,
                          shape: new RoundedRectangleBorder(
         borderRadius: new BorderRadius.circular(15.0)),
                          child: Text('Оформить заказ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )
                          ),
                        ),
                      ],
                    )
                  )
                ],
              );
            },
          );
  }
}

class ShoppingCartRow extends StatelessWidget {
  ShoppingCartRow(this.id, this.allproducts,
      {@required this.quantity, this.onPressed, this.addquantity, this.removequantity});

  int id;
  List allproducts;
  int quantity;
  final VoidCallback onPressed;
  final VoidCallback addquantity;
  final VoidCallback removequantity;

  @override
  Widget build(BuildContext context) {

    var currentProduct = allproducts.firstWhere((p) => p['id'] == id);

    AppStateModel model;
    final localTheme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60.0,
            child: IconButton(
              color: Colors.red,
              iconSize: 35,
              icon: const Icon(Icons.remove_shopping_cart),
              onPressed: () {
                // removeitems();
              }
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                    height: 75.0,
                    width: 75.0,
                    child: Image.network(currentProduct["images"][0]["src"]),
                  ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             '${currentProduct['name']}',
                             style: TextStyle(
                               color: Colors.black,
                             ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: FlatButton(
                                    onPressed: () {
                                      removequantity();
                                    },
                                    child: Icon(Icons.keyboard_arrow_left,
                                    size: 40,
                                    color: Colors.red,
                                    ),
                                  ),
                                  //child: Text('Количество: $quantity'),
                                  
                                ),
                                
                                Container(
                                  child: Text('$quantity',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                  )
                                  ),
                                ),
                                Expanded(
                                  child: FlatButton(
                                    onPressed: () {
                                      addquantity();
                                    },
                                    child: Icon(Icons.keyboard_arrow_right,
                                    size: 40,
                                    color: Colors.green,
                                    ),
                                  ),
                                ),
                                Text(
                                  //'product price',
                                  currentProduct['price'] == null? 'x ${currentProduct['price']} руб.': 'x ${currentProduct['price']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  ),
                              ],
                            ),
                            
                            
                            
                          ],
                        ),
                      ),
                        
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(
                    color: Colors.red,
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}