import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasematerial/controller/auth_controller.dart';
import 'package:firebasematerial/model/user_model.dart';
import 'package:firebasematerial/view/contact.dart';
import 'package:firebasematerial/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObsure = true;
  final formkey = GlobalKey<FormState>();
  // Add code Firebase Auth dan CollectionReference
  final authCtr = AuthController(
      FirebaseAuth.instance, FirebaseFirestore.instance.collection('users'));
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade100, Colors.pink.shade300],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.purple.shade50,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.pink,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: _isObsure,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.purple.shade50,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.pink,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObsure = !_isObsure;
                          });
                        },
                        icon: Icon(_isObsure
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      //border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        UserModel? loginUser =
                            await authCtr.signInWithEmailAndPassword(
                          email!,
                          password!,
                        );
                        if (loginUser != null) {
                          // Login successful
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Login Successful!'),
                                content: const Text(
                                    'You have been successfully logged in.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const Contact();
                                          },
                                        ),
                                      );
                                      //print(registeredUser.name);
                                      // Navigate to the next screen or perform any desired action
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Welcome ${loginUser.name}!',
                                          ),
                                          backgroundColor: Colors.pink,
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Login failed
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Login Failed'),
                                content: const Text(
                                    'An error occurred during logged in.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => Register(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
