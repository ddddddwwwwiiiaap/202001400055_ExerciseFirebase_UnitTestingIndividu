import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasematerial/controller/contact_controller.dart';
import 'package:firebasematerial/model/contact_model.dart';
import 'package:firebasematerial/view/contact.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  // Add code CollectionReference
  var contactController = ContactController(
      FirebaseFirestore.instance.collection('contacts'));
  final formKey = GlobalKey<FormState>();
  String? name;
  String? phone;
  String? email;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
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
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const CircleAvatar(
                            radius: 25,
                            child: Icon(
                              Icons.person,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onChanged: (value) => name = value,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            onChanged: (value) => phone = value,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onChanged: (value) => email = value,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Address',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            onChanged: (value) => address = value,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            child: const Text('Add Contact'),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                ContactModel cm = ContactModel(
                                  name: name!, //dari variabel di def. diatas
                                  phone: phone!,
                                  email: email!,
                                  address: address!,
                                );
                                contactController.addContact(cm).then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Contact(),
                                    ),
                                  );
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Contact Added'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
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
