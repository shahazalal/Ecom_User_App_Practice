import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user_app/models/customer_model.dart';
import 'package:ecom_user_app/models/product_model.dart';
import 'package:ecom_user_app/models/purchase_model.dart';

class DBFirebase {
  static final String _collectionAdmin = 'Admins';
  static final String _collectionProduct = 'ProdcutsPB01';
  static final String _collectionPurchase = 'PurchasePB01';
  static final String _collectionOrderConstants = 'OrderConstants';
  static final String _documentConstants = 'Constants';
  static final String _collectionOrder = 'OrdersPB01';
  static final String _collectionCategory = 'Categories';
  static final String _collectionCustomer = 'Customers';
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCategories() =>
      _db.collection(_collectionCategory).snapshots();

  static Future<String> addCustomer(CustomerModel customerModel) async {
    final docRef = _db.collection(_collectionCustomer).doc();
    customerModel.customerId = docRef.id;
    await docRef.set(customerModel.toMap());
    return docRef.id;
  }

  static Future<void> updateCustomer(CustomerModel customerModel) {
    final docRef =
        _db.collection(_collectionCustomer).doc(customerModel.customerId);
    return docRef.update(customerModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() =>
      _db.collection(_collectionProduct).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db
          .collection(_collectionOrderConstants)
          .doc(_documentConstants)
          .snapshots();

  static Future<CustomerModel?> findCustomerByPhone(String phone) async {
    CustomerModel? customerModel;
    final snapshot = await _db
        .collection(_collectionCustomer)
        .where('customerPhone', isEqualTo: phone)
        .get();
    if (snapshot.docs.length > 0) {
      customerModel = CustomerModel.fromMap(snapshot.docs.first.data());
    }
    return customerModel;
  }
}
