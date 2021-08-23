import 'package:ecom_user_app/auth/firebase_auth_service.dart';
import 'package:ecom_user_app/pages/customer_info_page.dart';
import 'package:ecom_user_app/providers/cart_provider.dart';
import 'package:ecom_user_app/utils/constant.dart';
import 'package:ecom_user_app/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static final String routeName = '/cart_page';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Consumer<CartProvider>(
          builder: (context, provider, _) => Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.cartModels.length,
                      itemBuilder: (context, index) {
                        final cartModel = provider.cartModels[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 6,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    cartModel.productName!,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  subtitle: Text(
                                      '$takaSymbol${cartModel.price} x ${cartModel.qty}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  trailing: Text(
                                    '$takaSymbol${provider.getItemSubTotal(cartModel)}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListTile(
                                  title: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Change Quantity: '),
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          provider.decreaseQuantity(cartModel);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          provider.increaseQuantity(cartModel);
                                        },
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      provider
                                          .removeFromCart(cartModel.productId!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: $takaSymbol${provider.getCartItemsTotalPrice}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (provider.totalItemsInCart > 0)
                          TextButton(
                              style:
                                  TextButton.styleFrom(primary: Colors.white),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, CustomerInfoPage.routeName);
                                // if (!FirebaseAuthService.isEmailVerified()) {
                                //   showEmailVerificationWarningDialog(context);
                                // } else {
                                //   Navigator.pushNamed(
                                //       context, CustomerInfoPage.routeName);
                                // }
                              },
                              child: Text('CheckOut')),
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}
