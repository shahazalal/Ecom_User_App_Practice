import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user_app/auth/firebase_auth_service.dart';
import 'package:ecom_user_app/models/order_model.dart';
import 'package:ecom_user_app/providers/cart_provider.dart';
import 'package:ecom_user_app/providers/order_provider.dart';
import 'package:ecom_user_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderConfirmPage extends StatefulWidget {
  static final String routeName = '/confirm_order';

  @override
  _OrderConfirmPageState createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {
  late CartProvider _cartProvider;
  late String _customerId;
  late OrderProvider _orderProvider;
  bool isInit = true;
  bool isLoading = true;
  String _paymentRadioGroupValue = PaymentMethod.cod;

  @override
  void didChangeDependencies() {
    _cartProvider = Provider.of<CartProvider>(context);
    _orderProvider = Provider.of<OrderProvider>(context);
    _customerId = ModalRoute.of(context)!.settings.arguments as String;
    if (isInit) {
      _orderProvider.getOrderConstants().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    print(_customerId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  buildInvoice(),
                  ListTile(
                    leading: Radio<String>(
                      value: PaymentMethod.cod,
                      groupValue: _paymentRadioGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _paymentRadioGroupValue = value!;
                        });
                      },
                    ),
                    title: Text(PaymentMethod.online),
                  ),
                  ListTile(
                    leading: Radio<String>(
                      value: PaymentMethod.online,
                      groupValue: _paymentRadioGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _paymentRadioGroupValue = value!;
                        });
                      },
                    ),
                    title: Text(PaymentMethod.cod),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _placeOrder();
                      },
                      child: Text('PLACE ORDER'))
                ],
              ),
            ),
    );
  }

  Widget buildInvoice() {
    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: _cartProvider.cartModels
                  .map((cartModel) => ListTile(
                        title: Text(cartModel.productName!),
                        subtitle: Text('${cartModel.price} X ${cartModel.qty}'),
                        trailing: Text(
                            '$takaSymbol${_cartProvider.getItemSubTotal(cartModel)}'),
                      ))
                  .toList(),
            ),
            Divider(
              height: 2,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$takaSymbol${_cartProvider.getCartItemsTotalPrice}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'After discount (${_orderProvider.orderConstantsModel?.discount}%):',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '$takaSymbol${_orderProvider.getTotalAfterDiscount(_cartProvider.getCartItemsTotalPrice)}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vat (${_orderProvider.orderConstantsModel?.vat}%):',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '$takaSymbol${_orderProvider.getTotalVatAmount(_cartProvider.getCartItemsTotalPrice)}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Charge:',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '$takaSymbol${_orderProvider.orderConstantsModel?.deliveryCharge}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '$takaSymbol${_orderProvider.getGrandTotal(_cartProvider.getCartItemsTotalPrice)}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _placeOrder() {
    final model = OrderModel(
        customerId: _customerId,
        userId: FirebaseAuthService.currentUser?.uid,
        deliverCharge: _orderProvider.orderConstantsModel!.deliveryCharge,
        vat: _orderProvider.orderConstantsModel!.vat,
        discount: _orderProvider.orderConstantsModel!.discount,
        grandTotal:
            _orderProvider.getGrandTotal(_cartProvider.getCartItemsTotalPrice),
        paymentMethod: _paymentRadioGroupValue,
        orderStatus: OrderStatus.pending,
        timestamp: Timestamp.fromDate(DateTime.now()));
    print(model);
  }
}
