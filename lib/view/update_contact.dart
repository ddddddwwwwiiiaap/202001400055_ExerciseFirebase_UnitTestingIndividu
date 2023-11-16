// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebasematerial/controller/contact_controller.dart';
import 'package:firebasematerial/model/contact_model.dart';
import 'package:firebasematerial/view/contact.dart';

class UpdateContact extends StatefulWidget {
  ContactModel contactModel;
  UpdateContact({
    Key? key,
    required DocumentSnapshot<Object?> contact,
    required this.contactModel,
  }) : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  // Add code CollectionReference
  var contactController =
      ContactController(FirebaseFirestore.instance.collection('contacts'));
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
        title: const Text('Update Contact'),
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
                            controller: TextEditingController(
                              text: widget.contactModel.name,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                            onChanged: (value) => name = value,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                              text: widget.contactModel.phone,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                            onChanged: (value) => phone = value,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                              text: widget.contactModel.email,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            onChanged: (value) => email = value,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                              text: widget.contactModel.address,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Address',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                            onChanged: (value) => address = value,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            child: const Text('Update Contact'),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ContactModel cm = ContactModel(
                                  id: widget.contactModel.id,
                                  name: name ?? widget.contactModel.name,
                                  phone: phone ?? widget.contactModel.phone,
                                  email: email ?? widget.contactModel.email,
                                  address:
                                      address ?? widget.contactModel.address,
                                );
                                contactController.updateContact(cm);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Contact Updated'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Contact(),
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
