import 'package:ecom_user_app/models/product_model.dart';
import 'package:ecom_user_app/providers/cart_provider.dart';
import 'package:ecom_user_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final ProductModel productModel;

  ProductItem(this.productModel);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                width: double.maxFinite,
                fadeInDuration: const Duration(seconds: 3),
                fadeOutCurve: Curves.bounceInOut,
                placeholder: 'images/placeholder.png',
                image: widget.productModel.imageDownloadUrl!),
          ),
          Text(
            widget.productModel.name!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '$takaSymbol${widget.productModel.price!}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.deepPurple),
          ),
          Consumer<CartProvider>(
            builder: (context, provider, _) => ElevatedButton(
              child: Text(provider.isInCart(widget.productModel.id!)
                  ? 'Remove From Cart'
                  : 'Add to Cart'),
              onPressed: () {
                if (provider.isInCart(widget.productModel.id!)) {
                  provider.removeFromCart(widget.productModel.id!);
                } else {
                  provider.addToCart(widget.productModel);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
