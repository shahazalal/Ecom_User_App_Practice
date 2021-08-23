import 'package:ecom_user_app/db/db_firebase.dart';
import 'package:ecom_user_app/models/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  List<String> categories = [];
  List<ProductModel> products = [];

  void getCategories() {
    DBFirebase.getCategories().listen((snapshot) {
      categories = List.generate(
          snapshot.docs.length, (index) => snapshot.docs[index].data()['name']);
      notifyListeners();
    });
  }

  Future<void> getProducts() async {
    DBFirebase.getProducts().listen((snapshot) {
      products = List.generate(snapshot.docs.length,
          (index) => ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
