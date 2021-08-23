import 'package:ecom_user_app/db/db_firebase.dart';
import 'package:ecom_user_app/models/order_constant_model.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
  OrderConstantsModel? orderConstantsModel;
  Future<void> getOrderConstants() async {
    DBFirebase.getOrderConstants().listen((snapshot) {
      if (snapshot.exists) {
        orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  num getTotalAfterDiscount(num total) {
    return (total - ((total * orderConstantsModel!.discount!) / 100)).round();
  }

  num getTotalVatAmount(num total) {
    final t = getTotalAfterDiscount(total);
    return ((t * orderConstantsModel!.vat!) / 100).round();
  }

  num getGrandTotal(num total) {
    return getTotalAfterDiscount(total) +
        getTotalVatAmount(total) +
        orderConstantsModel!.deliveryCharge!;
  }
}
