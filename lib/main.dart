// ignore_for_file: unused_import

import 'package:ecommerce/pages/register.dart';
import 'package:ecommerce/provider/cart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {return Cart();},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}