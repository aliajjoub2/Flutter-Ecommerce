import 'package:ecommerce/pages/register.dart';
import 'package:ecommerce/pages/verify_email.dart';
import 'package:ecommerce/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../shared/decorationtextfield.dart';
import '../shared/snackbar.dart';
import 'forgot_passowrd.dart';


class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  signIn() async {
 

    try {
       setState(() {
      isLoading = true;
    });
      
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
          // Stop indicator
    
     setState(() {
      isLoading = false;
    });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    }


  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Email : ",
                        suffixIcon: const Icon(Icons.email))),
                const SizedBox(
                  height: 33,
                ),
                TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? false : true,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Password : ",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: isVisable
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)))),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await signIn();
                    if (!mounted) return;
                     Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => VerifyEmailPage()),
                        );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BTNgreen),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "log in",
                              style: const TextStyle(fontSize: 19),
                            ),
                ),
                 const SizedBox(
                  height: 9,
                ),
                
                TextButton(
                  onPressed: (){
                    Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPassword()),
                          );
                  },
                   child: Text("Forgot password?",
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline)),)
                   ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do not have an account?",
                        style: TextStyle(fontSize: 18)),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text('sign up',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}