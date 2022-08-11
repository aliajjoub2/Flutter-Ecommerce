import 'package:ecommerce/pages/login.dart';
import 'package:ecommerce/shared/colors.dart';
import 'package:ecommerce/shared/decorationtextfield.dart';

import 'package:flutter/material.dart';


class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your username : ",
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
                            "Register",
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        const SizedBox(
                          height: 33,
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Do not have an account?",
                                style: TextStyle(fontSize: 18)),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                  );
                                },
                                child: const Text('sign in',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18))),
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
