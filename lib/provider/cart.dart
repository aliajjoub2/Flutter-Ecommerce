import 'package:ecommerce/model/item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List selectedProducts = [];
  double price = 0.0;

  add(Item product) {
    selectedProducts.add(product);
    price += product.price;
    price = double.parse((price).toStringAsFixed(2));
    
    notifyListeners();
  }

  delete(Item product) {
    selectedProducts.remove(product);
    price -= product.price;
    price = double.parse((price).toStringAsFixed(2));

    notifyListeners();
  }

  get itemCount {
    return selectedProducts.length;
  }
}

