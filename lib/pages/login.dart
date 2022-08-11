import 'package:ecommerce/pages/register.dart';
import 'package:ecommerce/shared/colors.dart';
import 'package:flutter/material.dart';

import '../shared/decorationtextfield.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Email : ",
                      )),
                  const SizedBox(
                    height: 33,
                  ),
                  TextField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Password : ",
                      )),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                   
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                     child: const Text(
                      "Sign in",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do not have an account?", style: TextStyle(fontSize: 18)),
                      TextButton(
                        onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()),
                              );
                        },
                        child:
                            const Text('sign up', style: TextStyle(color: Colors.black,fontSize: 18))),
                   
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
  }
}