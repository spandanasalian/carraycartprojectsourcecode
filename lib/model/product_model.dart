import 'package:flutter/material.dart';
import 'package:sdmecom/helper/hexColor_extension.dart';


class ProductModel {

 String? name;
String? image;
 String? description;
 String? size;
  String? price;
 String? productId;
  String? category;
Color? color;

  ProductModel({
    this.name,
    this.image,
   this.description,
  this.size,
  this.price,
   this.productId,
 this.category,
   this.color,
  });

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description'];
    size = map['size'];
    price = map['price'];
    productId = map['productId'];
    category = map['category'];
    color = HexColor.fromHex(map['color']);
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'size': size,
      'color': color.toString(),
     
      'price': price,
      'productId': productId,
      'category': category,
    };
  }
}
