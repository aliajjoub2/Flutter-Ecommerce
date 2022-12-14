// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/model/item.dart';
import 'package:ecommerce/pages/CheckOut.dart';
import 'package:ecommerce/pages/details.dart';
import 'package:ecommerce/pages/login.dart';
import 'package:ecommerce/provider/cart.dart';
import 'package:ecommerce/shared/ProductsAndPrice.dart';
import 'package:ecommerce/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/user_img_from_firestore.dart';
import 'profile_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [ProductsAndPrice()],
        backgroundColor: appbarGreen,
        title: const Text("Home"),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/1.webp"),
                        fit: BoxFit.cover),
                  ),
                  currentAccountPicture: ImgUser(),
                  accountEmail: Text("ali@yahoo.com",
                      style: TextStyle(
                        color: Color.fromARGB(255, 13, 13, 13),
                      )),
                  accountName: Text("ali Ajjoub",
                      style: TextStyle(
                        color: Color.fromARGB(255, 13, 13, 13),
                      )),
                ),
                ListTile(
                    title: const Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
                    }),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckOut(),
                        ),
                      );
                    }),
                ListTile(
                    title: const Text("my Profile"),
                    leading: const Icon(Icons.help_center),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ProfilePage(),
                        ),
                      );

                    }),
                ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    }),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: const Text("Developed by Ali Ajjoub ?? 2022",
                  style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 33),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(product: items[index]),
                    ),
                  );
                },
                child: GridTile(
                
                  footer: GridTileBar(
//backgroundColor: Color.fromARGB(66, 73, 127, 110),
                    trailing: IconButton(
                        color: Color.fromARGB(255, 62, 94, 70),
                        onPressed: () {
                          carttt.add(items[index]);
                        },
                        icon: Icon(Icons.add)),

                    leading: const Text("\$12.99"),

                    // ignore: prefer_const_constructors
                    title: Text(
                      "",
                    ),
                  ),
                    child: Stack(children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: -40,
                      left: -30,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(55),
                          child: Image.asset(items[index].imgPath)),
                    ),
                  ]),
                ),
              );
            }),
      ),
    );
  }
}
