import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String? name;
  String? category;
  num? price;
  String? imageDownloadUrl;
  String? description;
  int? stock;
  bool? isAvailable;
  Timestamp? purchaseDate;

  ProductModel(
      {this.id,
      this.name,
      this.category,
      this.price,
      this.imageDownloadUrl,
      this.description,
      this.stock,
      this.isAvailable = true,
      this.purchaseDate});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'imageDownloadUrl': imageDownloadUrl,
      'description': description,
      'stock': stock,
      'isAvailable': isAvailable,
      'purchaseDate': purchaseDate
    };
    return map;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      price: map['price'],
      imageDownloadUrl: map['imageDownloadUrl'],
      description: map['description'],
      stock: map['stock'],
      isAvailable: map['isAvailable'],
      purchaseDate: map['purchaseDate']);

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, category: $category, price: $price, imageDownloadUrl: $imageDownloadUrl, description: $description, stock: $stock, isAvailable: $isAvailable, purchaseDate: $purchaseDate}';
  }
}
