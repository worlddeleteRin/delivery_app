import 'package:scoped_model/scoped_model.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'dart:async';

class AppStateModel extends Model {

Map<int, int> _productsInCart = {};
Map<int, int> get productsInCart => Map.from(_productsInCart);

int get totalCartQuantity => _productsInCart.values.fold(0, (v, e) => v + e);

List _allproducts = [];


List get allproducts => _allproducts;

 Future getProducts() async {

    /// Initialize the API
    WooCommerceAPI wc_api = new WooCommerceAPI(
        "http://automotive24.ru",
        "ck_0d82f3506b549784ca0ba247ac62d794fcb335f0",
        "cs_92ba36f1eae2f0be6d7ea3751d8e6569be18fb9c"
    );
    
    /// Get data using the endpoint
    var p = await wc_api.getAsync("products");
    _allproducts = p;
    return p;
  }

 void addProductToCart(int productId) {
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 1;
    } else {
      _productsInCart[productId]++;
    }
    print(_productsInCart);
    notifyListeners();
  }

   void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId]--;
      }
    }

    notifyListeners();
  }

}