import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebasematerial/controller/contact_controller.dart';
import 'package:firebasematerial/model/contact_model.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late ContactController contactController;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    contactController = ContactController(fakeFirestore.collection('contacts'));
  });

  group('ContactController Tests', () {
    test('Add Contact Test', () async {
      final initialContacts = await contactController.getContact();
      expect(initialContacts.length, 0); // Pastikan tidak ada kontak saat ini

      // Tambahkan kontak baru
      await contactController.addContact(
        ContactModel(
          name: 'John Doe',
          phone: '1234567890',
          email: 'john@example.com',
          address: '123 Main St',
        ),
      );

      final updatedContacts = await contactController.getContact();
      expect(updatedContacts.length, 1); // Pastikan kontak berhasil ditambahkan
    });

    test('Update Contact Test', () async {
      final contact = ContactModel(
        name: 'Jane Smith',
        phone: '9876543210',
        email: 'jane@example.com',
        address: '456 Elm St',
      );
      await contactController.addContact(contact);

      final contacts = await contactController.getContact();
      final initialContact = contacts.first as QueryDocumentSnapshot;

      await contactController.updateContact1(
        initialContact.id,
        ContactModel(
          name: 'Jane Smith',
          phone: '5555555555',
          email: 'jane.smith@example.com',
          address: '789 Oak St',
        ),
      );

      final updatedContacts = await contactController.getContact();
      final updatedContact = updatedContacts.first as QueryDocumentSnapshot;

      expect(updatedContact['name'], 'Jane Smith'); // Pastikan kontak berhasil diubah
    });

    test('Delete Contact Test', () async {
      final contact = ContactModel(
        name: 'Alice',
        phone: '1111111111',
        email: 'alice@example.com',
        address: '321 Pine St',
      );
      await contactController.addContact(contact);

      final initialContacts = await contactController.getContact();
      final initialCount = initialContacts.length;

      final contactToDelete = initialContacts.first as QueryDocumentSnapshot;
      await contactController.deleteContact(contactToDelete.id);

      final updatedContacts = await contactController.getContact();
      expect(updatedContacts.length, initialCount - 1); // Pastikan kontak berhasil dihapus
    });
  });
}