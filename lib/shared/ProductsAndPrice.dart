

import 'package:ecommerce/pages/CheckOut.dart';
import 'package:ecommerce/provider/cart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsAndPrice extends StatelessWidget {
  const ProductsAndPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 50,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -3,
                  left: -10,
                  child: Container(
                    
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(210, 106, 58, 248),
                          shape: BoxShape.circle),
                      child: Text(
                        "${carttt.itemCount}",
                        style: TextStyle(
                            fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      )),
                ),
                Positioned(
                  
                 
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckOut(),
                            ),
                          );
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              "\$ ${carttt.price}",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}