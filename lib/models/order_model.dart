import 'package:cloud_firestore/cloud_firestore.dart';

final String ORDER_ID = 'orderid';
final String USER_ID = 'user_id';
final String ORDER_CUSTOMER_ID = 'orderCustomerId';
final String ORDER_TIMESTAMP = 'orderTimestamp';
final String ORDER_GRANDTOTAL = 'orderGrandTotal';
final String ORDER_DISCOUNT = 'orderDiscount';
final String ORDER_DELIVERY_CHARGE = 'orderDeliveryCharge';
final String ORDER_VAT = 'vat';
final String ORDER_ORDER_STATUS = 'orderStatus';
final String ORDER_PAYMENT_METHOD = 'orderPaymentMethod';

class OrderModel {
  String? orderId;
  Timestamp? timestamp;
  String? customerId;
  String? userId;
  num? grandTotal;
  int? discount;
  int? deliverCharge;
  int? vat;
  String? orderStatus;
  String? paymentMethod;

  OrderModel(
      {this.orderId,
      this.timestamp,
      this.customerId,
      this.userId,
      this.grandTotal,
      this.discount,
      this.deliverCharge,
      this.vat,
      this.orderStatus,
      this.paymentMethod});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'orderId': orderId,
      'timestamp': timestamp,
      'customerId': customerId,
      'userId': userId,
      'grandTotal': grandTotal,
      'discount': discount,
      'deliverCharge': deliverCharge,
      'vat': vat,
      'orderStatus': orderStatus,
      'paymentMethod': paymentMethod,
    };
    return map;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
        orderId: map['orderId'],
        timestamp: map['timestamp'],
        customerId: map['customerId'],
        userId: map['userId'],
        grandTotal: map['grandTotal'],
        discount: map['discount'],
        deliverCharge: map['deliverCharge'],
        vat: map['vat'],
        orderStatus: map['orderStatus'],
        paymentMethod: map['paymentMethod'],
      );

  @override
  String toString() {
    return 'OrderModel{orderId: $orderId, timestamp: $timestamp, customerId: $customerId, userId: $userId, grandTotal: $grandTotal, discount: $discount, deliverCharge: $deliverCharge, vat: $vat, orderStatus: $orderStatus, paymentMethod: $paymentMethod}';
  }
}
