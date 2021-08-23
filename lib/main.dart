import 'package:ecom_user_app/pages/cart_page.dart';
import 'package:ecom_user_app/pages/customer_info_page.dart';
import 'package:ecom_user_app/pages/launcher_page.dart';
import 'package:ecom_user_app/pages/login_page.dart';
import 'package:ecom_user_app/pages/order_confirm_page.dart';
import 'package:ecom_user_app/pages/product_list_page.dart';
import 'package:ecom_user_app/providers/cart_provider.dart';
import 'package:ecom_user_app/providers/customer_provider.dart';
import 'package:ecom_user_app/providers/order_provider.dart';
import 'package:ecom_user_app/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.red, appBarTheme: AppBarTheme(elevation: 0)),
        home: LauncherPage(),
        routes: {
          LauncherPage.routeName: (ctx) => LauncherPage(),
          LoginPage.routeName: (ctx) => LoginPage(),
          ProductListPage.routeName: (ctx) => ProductListPage(),
          CartPage.routeName: (ctx) => CartPage(),
          CustomerInfoPage.routeName: (ctx) => CustomerInfoPage(),
          OrderConfirmPage.routeName: (ctx) => OrderConfirmPage(),
        },
      ),
    );
  }
}
