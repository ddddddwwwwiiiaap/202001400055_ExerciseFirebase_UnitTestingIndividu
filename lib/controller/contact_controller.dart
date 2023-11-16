import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasematerial/model/contact_model.dart';

class ContactController {
  //global agar mengakses semua method dan properti

  // Comment code berikut untuk disconnect Collection 'contacts' ke Firebase DB
  // final contactCollection = FirebaseFirestore.instance
  //     .collection('contacts'); //contacts adalah nama collection di firestore

  // Add code CollectionReference
  final CollectionReference contactCollection;
  ContactController(this.contactCollection);

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();
    final DocumentReference docRef =
        await contactCollection.add(contact); //panggil contactCollection

    //untuk menambahkan document id
    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
      id: docId,
      name: ctmodel.name,
      phone: ctmodel.phone,
      email: ctmodel.email,
      address: ctmodel.address,
    );

    await docRef.update(contactModel.toMap());
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.add(contact.docs); // karena sifatnya document
    return contact.docs;
  }

  Future<void> updateContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();
    await contactCollection.doc(ctmodel.id).update(contact);
  }

  Future<void> updateContact1(String docId, ContactModel ctmodel) async {
    final ContactModel updateContactModel = ContactModel(
      id: docId,
      name: ctmodel.name,
      phone: ctmodel.phone,
      email: ctmodel.email,
      address: ctmodel.address,
    );

    final DocumentSnapshot documentSnapshot =
        await contactCollection.doc(docId).get(); //untuk mendapat doc. id
    //mengecek apakah document id ada atau tidak / error
    if (documentSnapshot.exists) {
      // print('Contact with ID $docId does not exists');
      return;
    }

    final updateContact =
        updateContactModel.toMap(); //untuk auto reload jika update
    await contactCollection.doc(docId).update(updateContact);
    await getContact();
    print('Update contact contact with ID: $docId');
  }

  Future<void> deleteContact(String id) async {
    await contactCollection.doc(id).delete();
    await getContact();

    // print('Delete contact with ID: $id');
  }
}
