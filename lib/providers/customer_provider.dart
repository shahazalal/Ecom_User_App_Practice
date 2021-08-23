import 'package:ecom_user_app/db/db_firebase.dart';
import 'package:ecom_user_app/models/customer_model.dart';
import 'package:flutter/cupertino.dart';

class CustomerProvider with ChangeNotifier {
  Future<CustomerModel?> getCustomerByPhone(String phone) =>
      DBFirebase.findCustomerByPhone(phone);
  Future<String> addCustomer(CustomerModel customerModel) =>
      DBFirebase.addCustomer(customerModel);
  Future<void> updateCustomer(CustomerModel customerModel) =>
      DBFirebase.updateCustomer(customerModel);
}
