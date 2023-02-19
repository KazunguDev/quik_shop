import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quik_shop/body_widgets/header_widget.dart';
import 'package:quik_shop/components/our_button.dart';
import 'package:quik_shop/constants.dart';

import 'package:quik_shop/screens/register_screen.dart';
import 'package:get/get.dart';
import 'package:quik_shop/screens/resetpassword_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double _headerHeight = 250;
  late String email;
  late String password;
  bool visiblePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(
                height: _headerHeight,
                child: HeaderWidget(height: _headerHeight, showIcon: false)),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                      const Text(
                        'Signin into your account',
                        style: TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins'),
                      ),
                      const SizedBox(height: 30.0),
                      Column(
                        children: [
                          TextFormField(
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Username',
                                hintText: 'Enter your username'),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Enter your First Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                            obscureText: visiblePassword,
                            decoration: kTextFieldDecoration.copyWith(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (visiblePassword == true) {
                                      visiblePassword = false;
                                    } else {
                                      visiblePassword = true;
                                    }
                                  });
                                },
                                icon: visiblePassword == true
                                    ? const Icon(CupertinoIcons.eye_fill)
                                    : const Icon(CupertinoIcons.eye_slash_fill),
                              ),
                              labelText: 'Password',
                              hintText: 'Enter your password',
                            ),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Enter your First Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => ResetPasswordScreen(),
                                    transition: Transition.cupertino);
                              },
                              child: Text("forgot your password?",
                                  style: kTextStyleSmallBold.copyWith(
                                      fontSize: 13)),
                            ),
                          ),
                        ],
                      ),
                      button(
                        'Sign In',
                        300,
                            () async {
                          try {
                            final signIn = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: email.trim(), password: password);
                          } on FirebaseAuthException catch (e) {
                            Get.snackbar(
                              'Enable to Login',
                              e.message.toString(),
                              duration: const Duration(seconds: 4),
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(7),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("New to KwikShop?",
                              style: kTextStyleSmall),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Get.off(() => RegistrationScreen(),
                                  transition: Transition.cupertino);
                            },
                            child: const Text(
                              "Sign Up",
                              style: kTextStyleSmallBold,
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}