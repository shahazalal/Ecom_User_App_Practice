import 'package:ecom_user_app/models/cart_model.dart';
import 'package:ecom_user_app/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartModels = [];
  void addToCart(ProductModel productModel) {
    cartModels.add(CartModel(
      productId: productModel.id,
      productName: productModel.name,
      price: productModel.price,
    ));
    notifyListeners();
  }

  void removeFromCart(String id) {
    final cartModel =
        cartModels.firstWhere((cartModel) => cartModel.productId == id);
    cartModels.remove(cartModel);
    notifyListeners();
  }

  num getItemSubTotal(CartModel cartModel) => cartModel.price! * cartModel.qty;

  int get totalItemsInCart => cartModels.length;

  bool isInCart(String id) {
    bool tag = false;
    for (var c in cartModels) {
      if (c.productId == id) {
        tag = true;
        break;
      }
    }
    return tag;
  }

  void increaseQuantity(CartModel cartModel) {
    var index = cartModels.indexOf(cartModel);
    cartModels[index].qty += 1;
    notifyListeners();
  }

  void decreaseQuantity(CartModel cartModel) {
    var index = cartModels.indexOf(cartModel);
    if (cartModels[index].qty > 1) {
      cartModels[index].qty -= 1;
    }
    notifyListeners();
  }

  num get getCartItemsTotalPrice {
    num total = 0;
    cartModels.forEach((model) {
      total += model.price! * model.qty;
    });
    return total;
  }
}
