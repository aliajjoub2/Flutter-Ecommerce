// ignore_for_file: unused_import

import 'package:ecommerce/pages/register.dart';
import 'package:ecommerce/provider/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/verify_email.dart';
import 'provider/google_signin.dart';
import 'shared/snackbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
          apiKey: "NFb6gj1vQD6lGkYPenc7x2OBK8Axzw",
          appId: "1:827931587356:web:b5e08588be85c6e7a1c0d9",
          messagingSenderId: "827931587356",
          projectId: "flutterecommerceali",
          authDomain: "flutterecommerceali.firebaseapp.com",
          storageBucket: "flutterecommerceali.appspot.com",
          measurementId: "G-4H1ZD6LJG5"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (context) {
    return Cart();
    }),
    ChangeNotifierProvider(create: (context) {
     return GoogleSignInProvider();
    }),
    ],
    child: MaterialApp(
    title: "myApp",
    debugShowCheckedModeBanner: false,
    home: StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(
    color: Colors.white,
      ));
    } else if (snapshot.hasError) {
    return showSnackBar(context, "Something went wrong");
    } else if (snapshot.hasData) {
    return const Home(); // home() OR VerifyEmailPage()
    } else {
    return Login();
    }
    },
    )),
    );
  }
}
