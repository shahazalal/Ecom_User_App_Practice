import 'package:ecom_user_app/auth/firebase_auth_service.dart';
import 'package:ecom_user_app/pages/cart_page.dart';
import 'package:ecom_user_app/pages/login_page.dart';
import 'package:ecom_user_app/providers/cart_provider.dart';
import 'package:ecom_user_app/providers/product_provider.dart';
import 'package:ecom_user_app/utils/helpers.dart';
import 'package:ecom_user_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  static final String routeName = '/products';

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductProvider provider;
  bool isInit = true;
  bool isLoading = true;
  @override
  void didChangeDependencies() {
    provider = Provider.of<ProductProvider>(context);

    if (isInit) {
      Future.delayed(Duration.zero, () {
        if (!FirebaseAuthService.isEmailVerified()) {
          showEmailVerificationWarningDialog(context);
        }
      });
      provider.getProducts().then((value) {
        setState(() {
          isLoading = false;
        });
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartPage.routeName);
                },
              ),
              Positioned(
                top: 5,
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(maxWidth: 20, maxHeight: 20),
                  child: FittedBox(
                      child: Consumer<CartProvider>(
                          builder: (context, provider, _) =>
                              Text('${provider.totalItemsInCart}'))),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade900,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuthService.logout().then((_) =>
                  Navigator.pushReplacementNamed(context, LoginPage.routeName));
            },
          )
        ],
        title: Text('All Products'),
      ),
      body: isLoading
          ? Center(
              child: Text('Please Wait'),
            )
          : GridView.count(
              padding: const EdgeInsets.all(4),
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 0.7,
              children: provider.products
                  .map((products) => ProductItem(products))
                  .toList()),
    );
  }
}
